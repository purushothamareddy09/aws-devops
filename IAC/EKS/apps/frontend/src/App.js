import React, { useState } from 'react';
import axios from 'axios';

function App() {
  const [message, setMessage] = useState('');
  const [status, setStatus] = useState('');

  const sendMessage = async (e) => {
    e.preventDefault();
    setStatus('');
    try {
      const res = await axios.post('/api/produce', { message });
      setStatus(res.data.status);
      setMessage('');
    } catch (err) {
      setStatus(err.response?.data?.error || 'Error sending message');
    }
  };

  return (
    <div style={{ maxWidth: 400, margin: '2rem auto', textAlign: 'center' }}>
      <h2>Send Message to Kafka</h2>
      <form onSubmit={sendMessage}>
        <input
          value={message}
          onChange={e => setMessage(e.target.value)}
          placeholder="Type your message"
          style={{ width: '80%', padding: 8 }}
        />
        <button type="submit" style={{ marginLeft: 8, padding: 8 }}>Send</button>
      </form>
      {status && <p style={{ marginTop: 16 }}>{status}</p>}
    </div>
  );
}

export default App;
