
const Login = ({email, setEmail, senha, setSenha, error, setError, handleLogin}) => {
  return(
    <form className="login">
        <h1>Login</h1>
        <input
            type="text"
            placeholder="Email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
        />
        <input
            type="password"
            placeholder="Password"
            required
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
        />
        <p value={error}></p>
        <button
            type="submit"
            onClick={() => inputRef.current.focus()}
        >Entrar</button>
    </form>
  )
}

export default Login