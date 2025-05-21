import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Button,
  Grid,
  FormControlLabel,
  Checkbox,
  MenuItem
} from '@mui/material';
import api from '../../services/api';

function BookingForm({ open, onClose }) {
  const [formData, setFormData] = useState({
    customer_id: '',
    screening_id: '',
    seat_number: '',
    payment_status: false
  });

  const [customers, setCustomers] = useState([]);
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    loadCustomers();
    loadMovies();
  }, []);

  const loadCustomers = async () => {
    try {
      const response = await api.getAllCustomers();
      setCustomers(response.data);
    } catch (error) {
      console.error('Error loading customers:', error);
    }
  };

  const loadMovies = async () => {
    try {
      const response = await api.getAllMovies();
      setMovies(response.data);
    } catch (error) {
      console.error('Error loading movies:', error);
    }
  };

  const handleChange = (e) => {
    const value = e.target.type === 'checkbox' ? e.target.checked : e.target.value;
    setFormData({
      ...formData,
      [e.target.name]: value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.createBooking(formData);
      onClose();
    } catch (error) {
      console.error('Error creating booking:', error);
    }
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>New Booking</DialogTitle>
      <form onSubmit={handleSubmit}>
        <DialogContent>
          <Grid container spacing={2}>
            <Grid item xs={12}>
              <TextField
                select
                name="customer_id"
                label="Customer"
                value={formData.customer_id}
                onChange={handleChange}
                fullWidth
                required
              >
                {customers.map((customer) => (
                  <MenuItem key={customer.customer_id} value={customer.customer_id}>
                    {customer.name}
                  </MenuItem>
                ))}
              </TextField>
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="screening_id"
                label="Screening ID"
                type="number"
                value={formData.screening_id}
                onChange={handleChange}
                fullWidth
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="seat_number"
                label="Seat Number"
                type="number"
                value={formData.seat_number}
                onChange={handleChange}
                fullWidth
                required
              />
            </Grid>
            <Grid item xs={12}>
              <FormControlLabel
                control={
                  <Checkbox
                    name="payment_status"
                    checked={formData.payment_status}
                    onChange={handleChange}
                  />
                }
                label="Payment Completed"
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button type="submit" variant="contained" color="primary">
            Create Booking
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
}

export default BookingForm;