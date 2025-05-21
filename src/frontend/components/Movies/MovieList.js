import React, { useState, useEffect } from 'react';
import { Grid, Card, CardContent, CardActions, Typography, Button, IconButton } from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import api from '../../services/api';
import MovieForm from './MovieForm';

function MovieList() {
  const [movies, setMovies] = useState([]);
  const [openForm, setOpenForm] = useState(false);
  const [selectedMovie, setSelectedMovie] = useState(null);

  useEffect(() => {
    loadMovies();
  }, []);

  const loadMovies = async () => {
    try {
      const response = await api.getAllMovies();
      setMovies(response.data);
    } catch (error) {
      console.error('Error loading movies:', error);
    }
  };

  const handleDelete = async (movieId) => {
    try {
      await api.deleteMovie(movieId);
      loadMovies();
    } catch (error) {
      console.error('Error deleting movie:', error);
    }
  };

  const handleEdit = (movie) => {
    setSelectedMovie(movie);
    setOpenForm(true);
  };

  const handleFormClose = () => {
    setSelectedMovie(null);
    setOpenForm(false);
    loadMovies();
  };

  return (
    <div>
      <Typography variant="h4" gutterBottom>
        Movies
        <Button variant="contained" color="primary" onClick={() => setOpenForm(true)} sx={{ ml: 2 }}>
          Add Movie
        </Button>
      </Typography>

      <Grid container spacing={3}>
        {movies.map((movie) => (
          <Grid item xs={12} sm={6} md={4} key={movie.movie_id}>
            <Card>
              <CardContent>
                <Typography variant="h6">{movie.title}</Typography>
                <Typography color="textSecondary">{movie.genre}</Typography>
                <Typography variant="body2">
                  Duration: {movie.duration}<br />
                  Rating: {movie.rating || 'N/A'}<br />
                  Release Date: {new Date(movie.release_date).toLocaleDateString()}
                </Typography>
                {movie.synopsis && (
                  <Typography variant="body2" sx={{ mt: 1 }}>
                    {movie.synopsis}
                  </Typography>
                )}
              </CardContent>
              <CardActions>
                <IconButton onClick={() => handleEdit(movie)}>
                  <Edit />
                </IconButton>
                <IconButton onClick={() => handleDelete(movie.movie_id)}>
                  <Delete />
                </IconButton>
              </CardActions>
            </Card>
          </Grid>
        ))}
      </Grid>

      <MovieForm
        open={openForm}
        onClose={handleFormClose}
        movie={selectedMovie}
      />
    </div>
  );
}

export default MovieList;