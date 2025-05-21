import React, { useState, useEffect } from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Button,
  Typography
} from '@mui/material';
import api from '../../services/api';
import BookingForm from './BookingForm';

function BookingList() {
  const [bookings, setBookings] = useState([]);
  const [openForm, setOpenForm] = useState(false);

  useEffect(() => {
    loadBookings();
  }, []);

  const loadBookings = async () => {
    try {
      const response = await api.getAllBookings();
      setBookings(response.data);
    } catch (error) {
      console.error('Error loading bookings:', error);
    }
  };

  const handleFormClose = () => {
    setOpenForm(false);
    loadBookings();
  };

  return (
    <div>
      <Typography variant="h4" gutterBottom>
        Bookings
        <Button variant="contained" color="primary" onClick={() => setOpenForm(true)} sx={{ ml: 2 }}>
          New Booking
        </Button>
      </Typography>

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Booking ID</TableCell>
              <TableCell>Customer ID</TableCell>
              <TableCell>Screening ID</TableCell>
              <TableCell>Seat Number</TableCell>
              <TableCell>Payment Status</TableCell>
              <TableCell>Booking Time</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {bookings.map((booking) => (
              <TableRow key={booking.booking_id}>
                <TableCell>{booking.booking_id}</TableCell>
                <TableCell>{booking.customer_id}</TableCell>
                <TableCell>{booking.screening_id}</TableCell>
                <TableCell>{booking.seat_number}</TableCell>
                <TableCell>{booking.payment_status ? 'Paid' : 'Pending'}</TableCell>
                <TableCell>{booking.booking_timestamp}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <BookingForm
        open={openForm}
        onClose={handleFormClose}
      />
    </div>
  );
}

export default BookingList;