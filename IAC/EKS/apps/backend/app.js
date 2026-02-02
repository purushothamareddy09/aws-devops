const express = require('express');
const { Kafka } = require('kafkajs');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const kafka = new Kafka({
  clientId: 'backend-app',
  brokers: [process.env.KAFKA_BROKER || 'my-kafka-cluster-kafka-bootstrap.kafka:9092']
});
const producer = kafka.producer();

app.post('/produce', async (req, res) => {
  const { message } = req.body;
  if (!message) return res.status(400).json({ error: 'Message is required' });
  try {
    await producer.connect();
    await producer.send({
      topic: process.env.KAFKA_TOPIC || 'demo-topic',
      messages: [{ value: message }]
    });
    await producer.disconnect();
    res.json({ status: 'Message sent to Kafka!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/', (req, res) => res.send('Kafka Backend is running'));

const port = process.env.PORT || 3001;
app.listen(port, () => console.log(`Backend listening on port ${port}`));
