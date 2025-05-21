import axios from 'axios';

const API_URL = 'http://127.0.0.1:8000';

const api = {
  // Movies
  getAllMovies: () => axios.get(`${API_URL}/movies`),
  getMovie: (id) => axios.get(`${API_URL}/movies/${id}`),
  createMovie: (movie) => axios.post(`${API_URL}/movies`, movie),
  updateMovie: (id, movie) => axios.put(`${API_URL}/movies/${id}`, movie),
  deleteMovie: (id) => axios.delete(`${API_URL}/movies/${id}`),

  // Customers
  getAllCustomers: () => axios.get(`${API_URL}/customers`),
  createCustomer: (customer) => axios.post(`${API_URL}/customers`, customer),
  updateCustomer: (id, customer) => axios.put(`${API_URL}/customers/${id}`, customer),

  // Bookings
  getAllBookings: () => axios.get(`${API_URL}/bookings`),
  getCustomerBookings: (customerId) => axios.get(`${API_URL}/bookings/customer/${customerId}`),
  createBooking: (booking) => axios.post(`${API_URL}/bookings`, booking),

  // Concessions
  getAllConcessions: () => axios.get(`${API_URL}/concessions`),
  purchaseConcession: (purchase) => axios.post(`${API_URL}/concessions/purchase`, purchase),
};

export default api;