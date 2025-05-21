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
import ConcessionForm from './ConcessionForm';

function ConcessionList() {
  const [concessions, setConcessions] = useState([]);
  const [openForm, setOpenForm] = useState(false);

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

  const handleFormClose = () => {
    setOpenForm(false);
    loadConcessions();
  };

  return (
    <div>
      <Typography variant="h4" gutterBottom>
        Concessions
        <Button variant="contained" color="primary" onClick={() => setOpenForm(true)} sx={{ ml: 2 }}>
          New Purchase
        </Button>
      </Typography>

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Product ID</TableCell>
              <TableCell>Name</TableCell>
              <TableCell>Price</TableCell>
              <TableCell>Stock Quantity</TableCell>
              <TableCell>Total Revenue</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {concessions.map((concession) => (
              <TableRow key={concession.product_id}>
                <TableCell>{concession.product_id}</TableCell>
                <TableCell>{concession.name}</TableCell>
                <TableCell>${concession.price.toFixed(2)}</TableCell>
                <TableCell>{concession.stock_quantity}</TableCell>
                <TableCell>${concession.total_revenue.toFixed(2)}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <ConcessionForm
        open={openForm}
        onClose={handleFormClose}
      />
    </div>
  );
}

export default ConcessionList;