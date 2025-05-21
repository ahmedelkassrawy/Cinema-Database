import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Container, AppBar, Toolbar, Typography, Button, Box } from '@mui/material';
import { Link } from 'react-router-dom';

function App() {
  return (
    <Router>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Cinema Management
          </Typography>
          <Button color="inherit" component={Link} to="/movies">Movies</Button>
          <Button color="inherit" component={Link} to="/customers">Customers</Button>
          <Button color="inherit" component={Link} to="/bookings">Bookings</Button>
          <Button color="inherit" component={Link} to="/concessions">Concessions</Button>
        </Toolbar>
      </AppBar>
      <Container sx={{ mt: 4 }}>
        <Routes>
          <Route path="/movies" element={<MovieList />} />
          <Route path="/customers" element={<CustomerList />} />
          <Route path="/bookings" element={<BookingList />} />
          <Route path="/concessions" element={<ConcessionList />} />
        </Routes>
      </Container>
    </Router>
  );
}

export default App;