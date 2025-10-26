import axios from "axios"

const API_URL = "http://localhost:8080/paymentRecords"

export const savePayment = (myorder)=>{
  retrun axios.post(`${API_URL}`,myorder)
}
