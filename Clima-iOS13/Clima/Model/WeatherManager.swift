import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager ,weather: WeatherModel)
    func didFailWithError(error : Error)
}

class WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    let weatherUrl : String = "https://api.openweathermap.org/data/2.5/weather?appid=7973dbff4cf12a4d209347f830cb1873&units=metric"
    
    func fetchWeather(cityName : String)  {
        let  urlString = weatherUrl + "&q=" + cityName
        self.performRequest(with: urlString)
    }
    
    func fetchWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees)  {
        let urlString = "\(weatherUrl)&lat=\(lattitude)&lon=\(longitude)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String)  {
        let url : URL? = URL(string: urlString)
        
        if url != nil {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task : URLSessionDataTask = session.dataTask(with: url!) {(data : Data?, response : URLResponse?, error : Error?) in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    let weather: WeatherModel? =  self.parseJson(safeData)
                    self.delegate?.didUpdateWeather(self, weather: weather!)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ jsonData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: jsonData)
            let name : String = decodedData.name
            let temp : Double = decodedData.main.temp
            let id : Int = decodedData.weather[0].id
            
            let weather : WeatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
