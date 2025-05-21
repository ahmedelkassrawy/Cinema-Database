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
  IconButton,
  Typography
} from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import api from '../../services/api';
import CustomerForm from './CustomerForm';

function CustomerList() {
  const [customers, setCustomers] = useState([]);
  const [openForm, setOpenForm] = useState(false);
  const [selectedCustomer, setSelectedCustomer] = useState(null);

  useEffect(() => {
    loadCustomers();
  }, []);

  const loadCustomers = async () => {
    try {
      const response = await api.getAllCustomers();
      setCustomers(response.data);
    } catch (error) {
      console.error('Error loading customers:', error);
    }
  };

  const handleEdit = (customer) => {
    setSelectedCustomer(customer);
    setOpenForm(true);
  };

  const handleFormClose = () => {
    setSelectedCustomer(null);
    setOpenForm(false);
    loadCustomers();
  };

  return (
    <div>
      <Typography variant="h4" gutterBottom>
        Customers
        <Button variant="contained" color="primary" onClick={() => setOpenForm(true)} sx={{ ml: 2 }}>
          Add Customer
        </Button>
      </Typography>

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Name</TableCell>
              <TableCell>Email</TableCell>
              <TableCell>Phone Number</TableCell>
              <TableCell>Loyal Points</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {customers.map((customer) => (
              <TableRow key={customer.customer_id}>
                <TableCell>{customer.name}</TableCell>
                <TableCell>{customer.email}</TableCell>
                <TableCell>{customer.phone_number || 'N/A'}</TableCell>
                <TableCell>{customer.loyal_points}</TableCell>
                <TableCell>
                  <IconButton onClick={() => handleEdit(customer)}>
                    <Edit />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      <CustomerForm
        open={openForm}
        onClose={handleFormClose}
        customer={selectedCustomer}
      />
    </div>
  );
}

export default CustomerList;