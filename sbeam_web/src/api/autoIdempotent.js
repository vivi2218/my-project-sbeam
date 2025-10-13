import axios from 'axios'

const API_URL = 'http://localhost:8080/app/idempotent'

export const createToken = () => {
  return axios.get(`${API_URL}/createToken`)
}
