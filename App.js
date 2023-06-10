import './App.css';
import {useState,useEffect} from 'react'
import axios from 'axios'

function App() {
    var d = new Date()

    const [ip,setIP] = useState('');
    const [timezone, setTimezone] = useState('');
    const [datetimeStr, setDatetimeStr] = useState('');
    
    //creating function to load ip address from the API
    const getData = async()=>{        
        const res_geo = await axios.get('https://geolocation-db.com/json/')
        setIP(res_geo.data.IPv4)

        const res_timez = await axios.get('https://api.wheretheiss.at/v1/coordinates/'
            +res_geo.data.latitude+','+res_geo.data.longitude)
        setTimezone(res_timez.data.timezone_id)
        setDatetimeStr(new Date().toLocaleString('pl-PL', {timeZone: res_timez.data.timezone_id.toString()}))
    }
    
    useEffect(()=>{
        //passing getData method to the lifecycle method
        getData()
    },[])

    console.log('Autor: Ivan Cherednichenko IIST 6.1 ')
    console.log('Data: ' + d.toDateString())
    console.log('PORT: ' + window.location.port)    

    return (
      <div>
        IP adres uzytkownika: {ip} <br/>
        Strefa czasowa: {timezone} <br/>
        Data i godzina w strefie czasowej uzytkownika: {datetimeStr}<br/>
       </div>
    );
  }
  export default App; 
