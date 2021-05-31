import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: 'api/v1',
  // headers: {
  //     'Authorization': `Bearer ${localStorage.token}`
  // }
})

if (localStorage.token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.token}`
}

export default axiosInstance