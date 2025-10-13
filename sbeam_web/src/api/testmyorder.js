import axios from 'axios'

const API_URL = 'http://localhost:8080/app/testmyorder'

export const testSaveMyorder = (testMyOrder) => {
  return axios.post(`${API_URL}`, testMyOrder, {
    headers: { formToken: testMyOrder.formToken },
  })
}
