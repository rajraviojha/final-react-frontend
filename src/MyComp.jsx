import { useState, useEffect } from "react";
import axios from "axios";
 
function MyComp() {
    const [data, setData] = useState([]);
 
    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await axios.get("https://localhost:7178/WeatherForecast");
                setData(res.data);
            } catch (error) {
                console.error("Error fetching data", error);
            }
        };
        fetchData();
    }, []);
 
    return (
        <div>
            {data.map((d, i) => (
                <>
                <div key={i} style={{ border: "2px solid white", padding:"5px" }}>
                    {d.date + " -- Temp in C - " + d.temperatureC + " -- Temp in F -  " + d.temperatureF + " -- Summary " + d.summary  }
                    <br />
                </div>
                </>
            ))}
        </div>
    );
}
 
export default MyComp;