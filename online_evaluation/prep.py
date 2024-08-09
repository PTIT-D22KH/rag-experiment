import os
import requests
import pandas as pd
from sentence_transformers import SentenceTransformer
from elasticsearch import Elasticsearch
from tqdm.auto import tqdm
from dotenv import load_dotenv
import pickle
import json

from db import init_db

load_dotenv()

ELASTIC_URL = os.getenv("ELASTIC_URL_LOCAL")
MODEL_NAME = os.getenv("MODEL_NAME")
INDEX_NAME = os.getenv("INDEX_NAME")

# BASE_URL = "https://github.com/DataTalksClub/llm-zoomcamp/blob/main"
BASE_PATH = "../data/vietnamese_rag"
NUM_FILES = 5

def load_documents(base_path, num_files):
    documents = []
    for i in range(1, num_files + 1):
        file_path = f'{base_path}/documents-with-ids{i}.json'
        with open(file_path, 'rt') as f_in:
            documents.extend(json.load(f_in))
    return documents

def fetch_documents():
    print("Fetching documents...")
    # base_path = '../data/vietnamese_rag'
    documents = load_documents(BASE_PATH, NUM_FILES)
    print(f"Fetched {len(documents)} documents")
    return documents


def fetch_ground_truth():
    print("Fetching ground truth data...")
    relative_path = "ground_truth_data/ground_truth_data.csv"
    ground_truth_url = f"{BASE_PATH}/{relative_path}"
    df_ground_truth = pd.read_csv(ground_truth_url)
    # df_ground_truth = df_ground_truth[
    #     df_ground_truth.course == "machine-learning-zoomcamp"
    # ]
    ground_truth = df_ground_truth.to_dict(orient="records")
    print(f"Fetched {len(ground_truth)} ground truth records")
    return ground_truth


def load_model():
    print(f"Loading model: {MODEL_NAME}")
    return SentenceTransformer(MODEL_NAME)


def setup_elasticsearch():
    print("Setting up Elasticsearch...")
    es_client = Elasticsearch(ELASTIC_URL)

    index_settings = {
        "settings": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        "mappings": {
            "properties": {
                "group": {"type": "keyword"},
                "context": {"type": "text"},
                "question": {"type": "text"},
                "answer": {"type": "text"},
                "id": {"type": "keyword"},
                "question_context_answer_vector": {
                    "type": "dense_vector",
                    "dims": 384,
                    "index": True,
                    "similarity": "cosine"
                },
            }
        }
    }

    es_client.indices.delete(index=INDEX_NAME, ignore_unavailable=True)
    es_client.indices.create(index=INDEX_NAME, body=index_settings)
    print(f"Elasticsearch index '{INDEX_NAME}' created")
    return es_client

def load_documents(file_path):
    with open(file_path, 'rt') as f_in:
        documents = json.load(f_in)
    return documents

def load_vectors(file_path):
    with open(file_path, 'rb') as file:
        return pickle.load(file)
def process_documents(documents, index_name, es_client):
    full_documents = []
    
    for i in range(1, 6):
        path = BASE_PATH + "/" + "question_context_answer_vector_pickle" + "/" + f"question_context_answer_vector{i}.pkl" 
        if i == 1:
            data = load_documents(path).copy()
        elif i == 2:
            data = load_documents(path).copy()
        elif i == 3:
            data = load_documents(path).copy()
        elif i == 4:
            data = load_documents(path).copy()
        elif i == 5:
            data = load_documents(path).copy()
        document_qta_vector_list = load_vectors(f'../data/vietnamese_rag/question_context_answer_vector_pickle/question_context_answer_vector{i}.pkl')

        for j in range(len(data)):
            data[j]['question_context_answer_vector'] = document_qta_vector_list[j]['question_context_answer_vector']
        full_documents.extend(data)
    for doc in tqdm(full_documents):
        es_client.index(index=index_name, document=doc)

def index_documents(es_client, documents, model):
    print("Indexing documents...")
    for doc in tqdm(documents): 
        doc["question_text_vector"] ;
        es_client.index(index=INDEX_NAME, document=doc)
    print(f"Indexed {len(documents)} documents")


def main():
    # you may consider to comment <start>
    # if you just want to init the db or didn't want to re-index
    print("Starting the indexing process...")

    documents = fetch_documents()
    ground_truth = fetch_ground_truth()
    model = load_model()
    es_client = setup_elasticsearch()
    index_documents(es_client, documents, model)
    # you may consider to comment <end>

    print("Initializing database...")
    init_db()

    print("Indexing process completed successfully!")


if __name__ == "__main__":
    main()
