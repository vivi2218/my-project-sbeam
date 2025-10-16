import axios from "axios";
const baseURL = "http://localhost:8080";

export function getMyLibrary(userId) {
  return axios.get(`${baseURL}/userGameLibrary/${userId}`);
}

export function removeGame(userId, gameId) {
  return axios.post(`${baseURL}/userGameLibrary/remove`, null, {
    params: { userId, gameId },
  });
}
