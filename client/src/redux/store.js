import { configureStore } from '@reduxjs/toolkit';

// Import reducers once they're created
// Example: import authReducer from './slices/authSlice';

// Placeholder reducer for initial structure
const placeholderReducer = (state = {}, action) => {
  return state;
};

const store = configureStore({
  reducer: {
    // Add your reducers here
    placeholder: placeholderReducer,
    // Example: auth: authReducer,
  },
});

export default store;
