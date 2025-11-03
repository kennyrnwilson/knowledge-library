# Stage 2: Working with AI Tools

**Goal:** Become an AI Builder - master AI APIs, prompt engineering, RAG, and build production AI applications

**Estimated Time:** 12-18 months part-time (10-15 hours/week)

**Entry Requirements:**
- Complete Stage 1 or equivalent software engineering knowledge
- Comfortable with Python, APIs, and databases
- Access to API keys (OpenAI, Anthropic, etc.)

## Overview

This is where you become job-ready. You'll learn how 90% of production AI work actually happens: integrating existing models into applications, not training new models.

**Key Insight:** Most AI engineers spend their time building applications with existing models, not training models from scratch. This stage reflects that reality.

## Why This Stage Matters

- **Job-Ready Timeline:** Complete this stage and you can get hired as an AI/ML engineer
- **Most Practical:** Focuses on skills that directly apply to real jobs
- **Fast Value:** Build working AI applications within weeks
- **Deep Understanding:** Learn why things work, not just how to use them

## Learning Path

### 2.1 AI APIs Integration (1-2 months)

**Foundation Model APIs**
- OpenAI (ChatGPT, GPT-4)
- Anthropic (Claude)
- Google (Gemini, PaLM)
- Cohere and others
- When to use which provider

**API Fundamentals**
- Authentication and API keys
- Request structure and parameters
- Streaming responses
- Token counting and cost estimation
- Error handling and retries
- Rate limiting

**Cost Optimization**
- Understanding pricing models
- Cost tracking and monitoring
- Choosing right model (speed vs quality)
- Caching strategies
- When to use cheaper models

**Production Patterns**
- Managing API keys securely
- Async requests for scalability
- Fallback strategies
- Monitoring and alerting
- Budget constraints

### 2.2 Prompt Engineering (2-3 months)

**Fundamental Techniques**
- Zero-shot prompting (asking without examples)
- Few-shot prompting (providing examples)
- Chain-of-Thought (making reasoning explicit)
- Role prompting (setting context)

**Advanced Patterns**
- ReAct (Reasoning + Acting)
- Self-Consistency (multiple reasoning paths)
- Tree of Thoughts (exploring solution space)
- Prompt Chaining (breaking complex tasks into steps)

**Output Formatting**
- Structured output (JSON, XML)
- Using delimiters
- Negative prompting (what NOT to do)
- Token budgeting

**Optimization & Testing**
- Systematic prompt testing
- A/B testing prompts
- Measuring quality
- Parameter tuning (temperature, top_p, max_tokens)
- Understanding model behavior

**System Prompts**
- Setting up system context
- Defining persona and tone
- Providing instructions
- Constraints and safety guidelines

### 2.3 RAG: Retrieval-Augmented Generation (3-4 months)

**The Complete RAG Pipeline**

1. **Indexing Phase**
   - Document processing
   - Chunking strategies (fixed, semantic, recursive)
   - Embedding models and selection
   - Vector database storage

2. **Retrieval Phase**
   - Vector similarity search
   - Metadata filtering
   - Reranking retrieved results
   - Query transformation

3. **Generation Phase**
   - Combining retrieved context with query
   - System prompts for grounded responses
   - Handling hallucinations
   - Source attribution

**Core Concepts**
- Embeddings: what they are and why they work
- Vector databases (Pinecone, Weaviate, ChromaDB, FAISS)
- Semantic vs keyword search
- Hybrid search (combining dense + sparse)
- Chunk size and overlap importance

**Advanced Techniques**
- Hypothetical Document Embeddings (HyDE)
- Query rewriting and expansion
- Multi-hop retrieval
- Graph-based retrieval
- Time-aware retrieval

**Evaluation**
- Retrieval metrics (precision, recall, NDCG)
- Generation metrics (faithfulness, relevance)
- LLM-as-judge evaluation
- Building evaluation datasets

**Why RAG Matters**
- Solves hallucination problem
- Provides context and grounding
- Enables use of proprietary data
- More cost-effective than fine-tuning
- Easier to keep current

### 2.4 Pre-trained Models (1-2 months)

**Model Landscape**
- Commercial models (GPT-4, Claude, Gemini)
- Open-source models (LLaMA, Mistral, Phi)
- Specialized models (task-specific, code, embeddings)
- Model selection framework

**Model Characteristics**
- Performance vs latency tradeoffs
- Context window size
- Instruction-following ability
- Cost considerations
- Availability

**Running Models Locally**
- Ollama (simple local models)
- LM Studio (model browser and interface)
- vLLM (optimized inference)
- Quantization (4-bit, 8-bit compression)

**Embedding Models**
- What embeddings are
- Popular models (OpenAI, open-source)
- Choosing embeddings for your use case
- Dimensionality and cost tradeoffs

**Multimodal Models**
- Vision capabilities (GPT-4V, Claude 3)
- Speech to text and text to speech
- When to use multimodal

### 2.5 Evaluation & Metrics (2 months)

**Types of Metrics**
- Quality metrics (how good is the output)
- Performance metrics (speed and cost)
- Reliability metrics (consistency and stability)
- User metrics (do humans prefer it)

**Traditional ML Metrics**
- Classification (accuracy, precision, recall, F1)
- Ranking (Precision@K, Recall@K, MRR, NDCG)
- Regression (MAE, RMSE, R²)

**LLM-Specific Evaluation**
- Faithfulness (staying grounded in facts)
- Relevance (answering the question)
- Completeness (covering all aspects)
- Coherence (logical flow)
- Consistency (not contradicting itself)

**Evaluation Methods**
- LLM-as-Judge (using Claude/GPT to evaluate)
- Human evaluation (gold standard)
- Automated metrics (BLEU, ROUGE, etc.)
- A/B testing with real users

**RAG-Specific Evaluation**
- Retrieval quality (right chunks retrieved?)
- Context relevance (context actually useful?)
- Answer faithfulness (answer grounded in context?)
- Complete evaluation pipeline

**Testing & Regression**
- Regression test suites
- Preventing quality degradation
- Monitoring in production
- Cost and performance tracking

### 2.6 Projects to Build (5 projects, 3-6 months each)

**[Project 1: Multi-Provider Chatbot](./projects/project-1-multimodal-chatbot.md)**
- Multi-turn conversations with memory
- Streaming responses
- Support multiple AI providers
- Cost tracking
- Web interface
- Time: 3-4 weeks

**[Project 2: RAG System](./projects/project-2-rag-system.md)**
- Document upload (PDF, DOCX, TXT, Markdown)
- Vector database integration
- Semantic search with citations
- Show retrieval sources
- Web interface
- Time: 4-5 weeks

**[Project 3: AI Agent](./projects/project-3-ai-agent.md)**
- Tool use / function calling
- Multiple tools (search, calculator, weather, Wikipedia)
- ReAct pattern
- Error recovery
- Execution trace
- Time: 3-4 weeks

**[Project 4: Model Comparison Study](./projects/project-4-model-comparison.md)**
- Zero-shot vs few-shot vs fine-tuned
- Comprehensive comparison
- Cost analysis
- Quality evaluation
- Written analysis
- Time: 2-3 weeks

**[Project 5: Full-Stack AI Application](./projects/project-5-full-stack-app.md)**
- Production-ready application
- Examples: Research Assistant, Code Generator, Support Bot
- Multiple AI features (RAG, agents, or both)
- Full authentication
- Deployed publicly
- Time: 5-6 weeks

## Learning Checklist

### AI APIs
- [ ] Get API keys from OpenAI, Anthropic, Google
- [ ] Make successful API calls in Python
- [ ] Handle API errors gracefully
- [ ] Stream responses
- [ ] Count tokens for cost estimation
- [ ] Implement retry logic
- [ ] Understand rate limiting
- [ ] Track API costs

### Prompt Engineering
- [ ] Write zero-shot prompts
- [ ] Use few-shot examples effectively
- [ ] Apply chain-of-thought technique
- [ ] Structure output with delimiters
- [ ] Get JSON responses reliably
- [ ] Use system prompts effectively
- [ ] Test and compare prompts
- [ ] Understand temperature and top_p

### RAG (Most Important!)
- [ ] Load documents into vector database
- [ ] Create embeddings from text
- [ ] Implement vector similarity search
- [ ] Filter by metadata
- [ ] Rerank retrieved results
- [ ] Build question-answering from documents
- [ ] Evaluate retrieval quality
- [ ] Handle multi-hop queries
- [ ] Cite sources in responses
- [ ] Evaluate answer quality

### Pre-trained Models
- [ ] Browse HuggingFace Hub
- [ ] Load and use open-source models
- [ ] Understand model cards
- [ ] Run models locally (Ollama)
- [ ] Choose right model for task
- [ ] Use different embedding models
- [ ] Understand quantization
- [ ] Compare model characteristics

### Evaluation
- [ ] Build test sets for your app
- [ ] Evaluate with LLM-as-Judge
- [ ] Implement A/B testing
- [ ] Track metrics over time
- [ ] Cost analysis
- [ ] Latency monitoring
- [ ] Human evaluation
- [ ] Regression test suite

## Completion Criteria

You've completed Stage 2 (and are job-ready) when you can:

- ✅ **Build RAG application from scratch**
  - Upload documents
  - Retrieve relevant context
  - Generate grounded answers
  - No tutorials needed

- ✅ **Optimize prompts systematically**
  - Test and compare variants
  - Measure quality improvements
  - Understand why changes work

- ✅ **Integrate multiple AI APIs**
  - Handle failures gracefully
  - Optimize costs
  - Switch providers if needed

- ✅ **Make architectural decisions**
  - API vs local models
  - Fine-tune vs prompt optimization
  - RAG vs retrieval chains
  - Explain your choices

- ✅ **Debug AI applications**
  - Trace through retrieval
  - Analyze prompt responses
  - Identify quality issues
  - Fix systematically

- ✅ **Estimate costs and latency**
  - Calculate token usage
  - Compare provider pricing
  - Plan for scale

- ✅ **Have 3+ substantial AI applications**
  - Deployed and public
  - Preferably with real users
  - Well-documented code
  - Evaluation metrics

## Time Breakdown

| Topic | Time | Notes |
|-------|------|-------|
| AI APIs | 4-6 weeks | Fast to learn, use immediately |
| Prompt Engineering | 6-8 weeks | Requires practice and experimentation |
| RAG (most critical) | 8-12 weeks | Most important - spend time here |
| Evaluation | 6-8 weeks | Essential for production apps |
| Projects | 12-18 weeks | Parallel with learning |
| **Total** | **12-18 months** | Depends on starting point |

## Resource Recommendations

**Courses**
- DeepLearning.AI short courses (free, excellent)
- LangChain documentation and tutorials
- HuggingFace courses (free)

**Documentation**
- OpenAI API docs
- Anthropic Claude documentation
- LangChain/LlamaIndex guides
- Vector database docs

**Books & Articles**
- "Building LLM-Powered Applications" (O'Reilly)
- LLM blog posts and tutorials
- ArXiv papers on RAG evaluation

## After Stage 2

Congratulations! You're now **job-ready as an AI Engineer**. You can:
- Interview for AI/ML engineer positions
- Build production AI applications
- Understand the AI landscape
- Make informed technology choices

## Optional: Move to Stage 3

Want to go deeper? **[Stage 3: Advanced AI Engineering](../stage-3-advanced-ai-engineering/index.md)** covers:
- Deep learning internals
- Production MLOps
- Model optimization
- Large-scale systems
- Takes 2-4 more years to master

## Related Areas

- [AI Engineering Roadmap Overview](../index.md)
- [Stage 1: Foundational Skills](../stage-1-foundational-skills/index.md)
- [Stage 3: Advanced AI Engineering](../stage-3-advanced-ai-engineering/index.md)
- [Teach to Learn](../../teach-to-learn.md)

---

*Last updated: 2025-11-03*
