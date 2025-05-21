import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Button,
  Grid
} from '@mui/material';
import api from '../../services/api';

function CustomerForm({ open, onClose, customer }) {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone_number: '',
    loyal_points: 0
  });

  useEffect(() => {
    if (customer) {
      setFormData({
        name: customer.name,
        email: customer.email,
        phone_number: customer.phone_number || '',
        loyal_points: customer.loyal_points || 0
      });
    } else {
      setFormData({
        name: '',
        email: '',
        phone_number: '',
        loyal_points: 0
      });
    }
  }, [customer]);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (customer) {
        await api.updateCustomer(customer.customer_id, formData);
      } else {
        await api.createCustomer(formData);
      }
      onClose();
    } catch (error) {
      console.error('Error saving customer:', error);
    }
  };

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>{customer ? 'Edit Customer' : 'Add Customer'}</DialogTitle>
      <form onSubmit={handleSubmit}>
        <DialogContent>
          <Grid container spacing={2}>
            <Grid item xs={12}>
              <TextField
                name="name"
                label="Name"
                value={formData.name}
                onChange={handleChange}
                fullWidth
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="email"
                label="Email"
                type="email"
                value={formData.email}
                onChange={handleChange}
                fullWidth
                required
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="phone_number"
                label="Phone Number"
                value={formData.phone_number}
                onChange={handleChange}
                fullWidth
              />
            </Grid>
            <Grid item xs={12}>
              <TextField
                name="loyal_points"
                label="Loyal Points"
                type="number"
                value={formData.loyal_points}
                onChange={handleChange}
                fullWidth
              />
            </Grid>
          </Grid>
        </DialogContent>
        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button type="submit" variant="contained" color="primary">
            {customer ? 'Update' : 'Add'}
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
}

export default CustomerForm;