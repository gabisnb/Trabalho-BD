import './App.css';
import Login from './Login';
import { useState, useEffect } from 'react';
import { userByCredentials } from '../persistence/UserPersistence.js';
import { PrismaClient } from '@prisma/client';

function App() {

  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');

  const handleLogin = (e) => {
    e.preventDefault();

    if(!email)
      return alert('Email is required');

    if(!senha)
      return alert('Password is required');

    let user = userByCredentials(email, senha);
    console.log(user);
    if(user == null){
      setError('Email or password is incorrect');
      return;
    }

    setEmail('');
    setSenha('');
  }

  return(
    <>
      <Login
        email={email}
        setEmail={setEmail}
        senha={senha}
        setSenha={setSenha}
        error={error}
        setError={setError}
        handleLogin={handleLogin}
      />
    </>
  )
}

export default App
