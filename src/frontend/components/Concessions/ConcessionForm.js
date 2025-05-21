import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Button,
  Grid,
  MenuItem
} from '@mui/material';
import api from '../../services/api';

function ConcessionForm({ open, onClose }) {
  const [formData, setFormData] = useState({
    product_id: '',
    quantity: 1,
    booking_id: ''
  });

  const [concessions, setConcessions] = useState([]);

  useEffect(() => {
    loadConcessions();
  }, []);

  const loadConcessions = async () => {
    try {
      const response = await api.getAllConcessions();
      setConcessions(response.data);
    } catch (error) {
      console.error('Error loading concessions:', error);
    }
  };

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.purchaseConcession(formData);
      onClose();
    } catch (error) {
      console.error('Error purchasing concession:', error);
    }
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>Purchase Concession</DialogTitle>
      <form onSubmit={handleSubmit}>
        <DialogContent>
          <Grid container spacing={2}>
            <Grid item xs={12}>
              <TextField
                select
                name="product_id"
                label="Product"
                value={formData.product_id}
                onChange={handleChange}
                fullWidth
                required
              >
                {concessions.map((concession) => (
                  <MenuItem key={concession.product_id} value={concession.product_id}>
                    {concession.name} - ${concession.price.toFixed(2)}
                  </MenuItem>
                ))}
              </TextField>
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="quantity"
                label="Quantity"
                type="number"
                value={formData.quantity}
                onChange={handleChange}
                fullWidth
                required
                inputProps={{ min: 1 }}
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="booking_id"
                label="Booking ID (Optional)"
                type="number"
                value={formData.booking_id}
                onChange={handleChange}
                fullWidth
                inputProps={{ min: 1 }}
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button type="submit" variant="contained" color="primary">
            Purchase
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
}

export default ConcessionForm;