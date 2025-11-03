# 🧾 RAG (Retrieval-Augmented Generation)

**Estimated Time:** 4-6 weeks
**Importance:** ⭐⭐⭐⭐⭐ MOST CRITICAL STAGE 2 SKILL

## Why RAG Matters

RAG is the **single most important skill** for production AI engineering because it:
- Solves hallucination (LLMs making up facts)
- Enables use of proprietary/personal data
- More cost-effective than fine-tuning
- Keeps information current
- Provides source attribution

## Complete Learning Path

### 1. RAG Fundamentals

**How RAG Works: The Complete Pipeline**

RAG consists of 3 phases:

**Indexing Phase** (Preparation)
- Load documents
- Split into chunks
- Generate embeddings
- Store in vector database
- Happens once, beforehand

**Retrieval Phase** (Query time)
- Take user query
- Generate embedding for query
- Search vector database
- Find similar chunks
- Return top K results

**Generation Phase** (Query time)
- Combine retrieved context with query
- Send to LLM
- LLM generates answer grounded in context
- Include source citations

### 2. Core Concepts

**Embeddings: The Foundation**
- What: Numerical representation of text
- Why: Enable semantic similarity search
- How: Special ML models convert text → vectors
- Popular models:
  - OpenAI: text-embedding-3-small (cheap), text-embedding-3-large (best)
  - Open-source: all-MiniLM-L6-v2 (free, decent)
  - Specialized: BGE, E5 (better for retrieval)

**Vector Databases**
- Specialized for similarity search
- Options:
  - **Managed**: Pinecone, Weaviate, Qdrant (easiest)
  - **Self-hosted**: ChromaDB (simplest), FAISS (fastest), Milvus (scalable)
  - **Hybrid**: Hybrid search combines dense + sparse

### 3. Document Processing & Chunking

**Why Chunking Matters**
- Full documents too long for context
- Need to split into meaningful pieces
- Chunk size affects quality and cost

**Chunking Strategies**
- **Fixed-Size**: Split every N tokens (simple, less semantic)
- **Semantic**: Split based on meaning (better quality)
- **Recursive**: Split by sentences, then by tokens (good balance)

**Chunk Size Guidelines**
- Too small: Lost context
- Too large: High cost, context noise
- **Sweet spot**: 256-1024 tokens (varies by use case)
- **Overlap**: 10-20% helps with context continuity

### 4. Advanced RAG Techniques

**Hybrid Search**
- Combine dense (semantic) + sparse (keyword) search
- Better coverage than either alone
- Catches both semantic and exact matches

**Query Transformation**
- Rewrite user query for better retrieval
- Add clarification or context
- Multiple reformulations for breadth

**Reranking**
- Initial retrieval might not be perfect
- Rerank results by relevance
- LLM-based reranking most effective

**Hypothetical Document Embeddings (HyDE)**
- Generate hypothetical document for query
- Retrieve using hypothetical document
- Often better than query embedding

### 5. RAG Evaluation

**Retrieval Quality Metrics**
- Precision@K: Are top K results relevant?
- Recall@K: Did we find all relevant docs?
- MRR (Mean Reciprocal Rank): How high is first relevant?
- NDCG (Normalized DCG): Quality of ranking

**Generation Quality Metrics**
- **Faithfulness**: Answer grounded in context?
- **Relevance**: Does it answer the question?
- **Completeness**: Does it cover all aspects?

**LLM-as-Judge**
- Use Claude/GPT to evaluate answers
- Cheaper than human evaluation
- Useful for iteration and testing

### 6. Complete Implementation Checklist

- [ ] Understand RAG pipeline (indexing → retrieval → generation)
- [ ] Know major vector database options
- [ ] Implement document loading
- [ ] Implement document chunking
- [ ] Generate embeddings
- [ ] Store in vector database
- [ ] Implement similarity search
- [ ] Implement retrieval-augmented generation
- [ ] Add source citation
- [ ] Handle edge cases (no results found, etc.)
- [ ] Evaluate retrieval quality
- [ ] Evaluate generation quality
- [ ] Optimize chunk size
- [ ] Test with real documents
- [ ] Measure cost and latency

### 7. Common Patterns

**Simple RAG**
```
User Query → Embedding → Vector Search → LLM Generation
```

**RAG with Reranking**
```
Query → Embedding → Coarse Search (100 results)
  → Reranker (top 10) → LLM Generation
```

**Hybrid Search RAG**
```
Query → Dense + Sparse Search → Combine Results
  → LLM Generation
```

## Resources & Learning

**Official Docs**
- LangChain RAG documentation
- LlamaIndex (formerly GPT Index)
- Vector database documentation

**Courses**
- DeepLearning.AI Short Course (free)
- LangChain documentation tutorials

**Papers** (Optional, advanced)
- "Retrieval-Augmented Generation for Large Language Models"
- RAG evaluation papers

## Learning Timeline

| Week | Topic | Focus |
|------|-------|-------|
| 1 | RAG fundamentals | Understand the 3-phase pipeline |
| 1 | Embeddings & vectors | Why embeddings work |
| 2 | Document processing | Chunking strategies |
| 2 | Vector databases | Try ChromaDB, Pinecone |
| 3 | Implementation | Build basic RAG system |
| 3-4 | Advanced techniques | Reranking, HyDE, hybrid |
| 4-5 | Evaluation | Measure quality |
| 5-6 | Optimization | Chunk size, embedding choice |
| 6 | Project | Build production RAG |

## Related Learning

- [AI APIs Integration](../index.md#21-ai-apis-integration) - Using APIs for embeddings
- [Pre-trained Models](../index.md#24-pre-trained-models) - Local embedding models
- [Evaluation Metrics](../index.md#25-evaluation-metrics) - RAG-specific metrics

## Next Steps

1. Start with ChromaDB (simplest local vector DB)
2. Use OpenAI embeddings API
3. Build basic RAG with a single document
4. Add document preprocessing
5. Implement evaluation
6. Try advanced techniques
7. Build [Project 2: RAG System](../projects/project-2-rag-system.md)

## Key Takeaways

- RAG is the most important Stage 2 skill ⭐⭐⭐⭐⭐
- 3-phase pipeline: Index → Retrieve → Generate
- Chunking and embedding quality matter most
- Always evaluate your RAG system
- Production RAG is more complex (reranking, hybrid, etc.)

---

*Last updated: 2025-11-03*
