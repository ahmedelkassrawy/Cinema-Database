import React, { useState } from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Button,
  Grid
} from '@mui/material';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import { LocalizationProvider, DatePicker } from '@mui/x-date-pickers';
import Notification from '../common/Notification';
import api from '../../services/api';

function MovieForm({ open, onClose }) {
  const [formData, setFormData] = useState({
    title: '',
    genre: '',
    duration: '',
    rating: '',
    release_date: null,
    synopsis: ''
  });

  const [notification, setNotification] = useState({
    open: false,
    message: '',
    severity: 'success'
  });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleDateChange = (date) => {
    setFormData({
      ...formData,
      release_date: date
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.createMovie(formData);
      setNotification({
        open: true,
        message: 'Movie created successfully!',
        severity: 'success'
      });
      onClose();
    } catch (error) {
      setNotification({
        open: true,
        message: error.response?.data?.detail || 'Error creating movie',
        severity: 'error'
      });
    }
  };

  const handleNotificationClose = () => {
    setNotification({
      ...notification,
      open: false
    });
  };

  return (
    <>
      <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
        <DialogTitle>New Movie</DialogTitle>
        <form onSubmit={handleSubmit}>
          <DialogContent>
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <TextField
                  name="title"
                  label="Title"
                  value={formData.title}
                  onChange={handleChange}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  name="genre"
                  label="Genre"
                  value={formData.genre}
                  onChange={handleChange}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  name="duration"
                  label="Duration (minutes)"
                  type="number"
                  value={formData.duration}
                  onChange={handleChange}
                  fullWidth
                  required
                  inputProps={{ min: 1 }}
                />
              </Grid>
              <Grid item xs={6}>
                <TextField
                  name="rating"
                  label="Rating"
                  value={formData.rating}
                  onChange={handleChange}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={12}>
                <LocalizationProvider dateAdapter={AdapterDateFns}>
                  <DatePicker
                    label="Release Date"
                    value={formData.release_date}
                    onChange={handleDateChange}
                    renderInput={(params) => <TextField {...params} fullWidth required />}
                  />
                </LocalizationProvider>
              </Grid>
              <Grid item xs={12}>
                <TextField
                  name="synopsis"
                  label="Synopsis"
                  value={formData.synopsis}
                  onChange={handleChange}
                  fullWidth
                  multiline
                  rows={4}
                  required
                />
              </Grid>
            </Grid>
          </DialogContent>
          <DialogActions>
            <Button onClick={onClose}>Cancel</Button>
            <Button type="submit" variant="contained" color="primary">
              Create Movie
            </Button>
          </DialogActions>
        </form>
      </Dialog>

      <Notification
        open={notification.open}
        message={notification.message}
        severity={notification.severity}
        onClose={handleNotificationClose}
      />
    </>
  );
}

export default MovieForm;