import axios from "axios"

const API_URL = "http://localhost:8080/paymentRecords"

export const savePayment = (myorder)=>{
  return axios.post(API_URL,myorder,{
    headers: {
      "Content-Type": "application/json" // 明确指定JSON格式，确保后端正确解析@RequestBody
    }
    });
};
