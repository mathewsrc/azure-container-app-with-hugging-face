from transformers import pipeline
from fastapi import FastAPI, Response
from pydantic import BaseModel

generator = pipeline('text-generation', model='gpt2')

app = FastAPI()


class Body(BaseModel):
    text: str


@app.get('/')
def root():
    return Response("<h1>API to generate text</h1>")


@app.post('/generate')
def predict(body: Body):
    results = generator(body.text, max_length=50, num_return_sequences=1)
    return results[0]
