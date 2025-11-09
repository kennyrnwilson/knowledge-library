# 🏗️ 2.6 Projects to Build

Build a portfolio of substantial AI projects that demonstrate your ability to create production-ready applications and land your first AI engineering role.

**← Back to**: [Stage 2: Working with AI Tools](../README.md)

---

## 📚 What You'll Learn

- Building production-ready multi-modal chatbots with streaming and cost tracking
- Implementing complete RAG systems with document processing and evaluation
- Creating AI agents with tool use and multi-step reasoning capabilities
- Fine-tuning models and comparing approaches (zero-shot, few-shot, fine-tuned)
- Developing full-stack AI applications with authentication and deployment
- Portfolio presentation best practices for GitHub and live deployments
- Documentation standards for technical project communication
- Production concerns including error handling, monitoring, and scalability

---

## 🔗 Learning Resources

**Related Areas:**
- [[Prompt Engineering]] - Essential for all projects
- [[RAG Applications]] - Foundation for Project 2
- [[AI Agents]] - Core of Project 3
- [[Evaluation Metrics]] - Required for all projects
- [[Production Deployment]] - Deployment skills needed

**Essential Skills:**
- Full-stack development (frontend + backend)
- API integration with multiple AI providers
- Database design and management
- User authentication and authorization
- Cost optimization and monitoring
- Comprehensive documentation practices

---

## Why Projects Matter

Companies hire based on what you've built, not courses completed.

**Portfolio-Worthy Projects:**
- Solve real problems
- Go beyond tutorials
- Well-documented
- Deployed and working
- Show production concerns
- Demonstrate technical depth

**Not Portfolio-Worthy:**
- Following tutorials exactly
- Simple API wrappers
- No documentation
- Broken deployments
- No clear problem solved

---

## The 5 Essential Stage 2 Projects

---

## Project 1: Advanced Multi-Modal Chatbot

**Objective:** Production-ready chatbot beyond simple API wrappers

### Core Features

**Must Have:**
- [ ] Multi-turn conversation with memory
- [ ] Streaming responses (real-time token output)
- [ ] Multiple AI providers (switch between OpenAI, Anthropic, etc.)
- [ ] Cost tracking (show cost per request)
- [ ] Error handling (graceful failures)
- [ ] Conversation persistence (save/load conversations)
- [ ] Clean web interface

**Nice to Have:**
- [ ] User authentication
- [ ] Conversation export (JSON, PDF)
- [ ] Voice input/output
- [ ] Image understanding
- [ ] Custom system prompts per conversation
- [ ] Analytics dashboard

### Technical Stack

```
Frontend: Next.js + React or Streamlit
Backend: FastAPI/Flask + Redis + PostgreSQL
Deployment: Vercel (frontend) + Railway (backend)
AI: OpenAI SDK + Anthropic SDK
```

### Skills Demonstrated

- API integration (multiple providers)
- Real-time streaming
- State management
- Database design
- Cost optimization
- Production deployment
- UX design

### Success Criteria

- [ ] Handles 10+ turn conversations smoothly
- [ ] Streaming works smoothly in UI
- [ ] Accurate cost tracking
- [ ] Graceful error handling
- [ ] Deployed and publicly accessible
- [ ] Comprehensive README with setup/usage
- [ ] Can switch between providers easily

---

## Project 2: Chat With Your Documents (RAG)

**Objective:** Complete RAG application demonstrating deep understanding

### Core Features

**Must Have:**
- [ ] Upload multiple documents (PDF, TXT, DOCX, Markdown)
- [ ] Document processing and chunking
- [ ] Vector database integration
- [ ] Semantic search with citations
- [ ] Show source chunks in responses
- [ ] Handle "I don't know" gracefully
- [ ] Evaluation metrics dashboard

**Nice to Have:**
- [ ] Hybrid search (keyword + semantic)
- [ ] Reranking of results
- [ ] Multiple collections/document sets
- [ ] Query expansion
- [ ] Web page ingestion
- [ ] Auto-summarization

### Technical Stack

```
Document Processing: LangChain, PyPDF2, RecursiveCharacterTextSplitter
Vector Database: Pinecone, ChromaDB, Qdrant, or Weaviate
LLM: OpenAI (gpt-3.5-turbo) or Anthropic Claude
Embeddings: text-embedding-3-small or voyage-ai
Frontend: Streamlit or custom React
Evaluation: RAGAS framework
```

### Advanced Features

**Smart Chunking:**
- Preserve document structure
- Include metadata with chunks
- Semantic chunking (split on meaning)

**Citation System:**
- Show exact source text
- Include document name and page
- Link to original document

**Evaluation Dashboard:**
- Retrieval precision/recall metrics
- Faithfulness scores (hallu detection)
- Response time tracking
- Cost per query
- Document statistics

### Skills Demonstrated

- Document processing pipeline
- Embedding generation
- Vector search
- RAG architecture
- Prompt engineering for accuracy
- Citation/attribution
- Evaluation methodology

### Success Criteria

- [ ] Processes 3+ document types
- [ ] Achieves 80%+ faithfulness score
- [ ] Provides relevant citations
- [ ] Tracks retrieval metrics
- [ ] Handles edge cases
- [ ] Deployed with working document upload
- [ ] Comprehensive README with examples

---

## Project 3: AI Agent With Tool Use

**Objective:** Autonomous agent using multiple tools for complex tasks

### Core Features

**Must Have:**
- [ ] Function calling / tool use
- [ ] 3-4 different tools integrated
- [ ] Multi-step reasoning (ReAct pattern)
- [ ] Error recovery and retries
- [ ] Execution trace showing reasoning

**Tools to Implement:**
1. Web Search (Serp API or DuckDuckGo)
2. Calculator (math operations)
3. Weather API (current weather)
4. Wikipedia Lookup
5. Database Query (SQL generation)

### Example Capabilities

Query: "What's the weather in Paris and should I bring an umbrella?"

Agent reasoning:
1. Thought: "I need to get Paris weather"
2. Action: Use weather tool for Paris
3. Observation: "Rainy, 60°F"
4. Thought: "Rain means umbrella needed"
5. Answer: "Yes, bring umbrella - it's rainy in Paris"

### Implementation

```python
from openai import OpenAI

tools = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Get weather for a location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {"type": "string"},
                },
                "required": ["location"],
            },
        },
    },
    # ... more tools
]

def run_agent(query):
    messages = [{"role": "user", "content": query}]

    while True:
        response = client.chat.completions.create(
            model="gpt-4",
            messages=messages,
            tools=tools,
        )

        # Check if agent wants to use tool
        if response.stop_reason == "tool_calls":
            # Execute tool and add result
            ...
        else:
            # Agent is done, return answer
            return response.choices[0].message.content
```

### Skills Demonstrated

- Function calling / tool use
- Multi-step reasoning (ReAct)
- API integrations
- Error handling and recovery
- Agent architecture

### Success Criteria

- [ ] Completes multi-step tasks with 2+ tools
- [ ] Clear reasoning trace visible
- [ ] Graceful error handling
- [ ] At least 4 working tools
- [ ] Deployed web interface
- [ ] Clear documentation of capabilities

---

## Project 4: Model Fine-Tuning Comparison

**Objective:** Demonstrate when/how to fine-tune vs prompt engineering

### Project Scope

Pick a specific use case:
- Customer support classification
- Code documentation generation
- Product descriptions from specs
- SQL query generation
- Medical/legal summarization

### Three Approaches

**Approach 1: Zero-Shot**
```python
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "user", "content": query}
    ]
)
```

**Approach 2: Few-Shot Prompting**
```python
prompt = f"""
Examples:
Input: {example1_input}
Output: {example1_output}

Input: {example2_input}
Output: {example2_output}

Input: {query}
Output:
"""
```

**Approach 3: Fine-Tuning**
```python
import openai

# Prepare training data
training_data = [
    {"messages": [
        {"role": "user", "content": "..."},
        {"role": "assistant", "content": "..."}
    ]},
    # ... more examples
]

# Fine-tune model
job = openai.FineTuningJob.create(
    training_file=file_id,
    model="gpt-3.5-turbo"
)
```

### Evaluation & Comparison

Create comparison table:

| Metric | Zero-Shot | Few-Shot | Fine-Tuned |
|--------|-----------|----------|------------|
| Accuracy | 75% | 85% | 92% |
| Cost/Request | $0.002 | $0.002 | $0.003 |
| Latency (ms) | 800 | 800 | 1200 |
| Dev Time (hrs) | 0.5 | 4 | 8 |

### Skills Demonstrated

- Data collection and curation
- Fine-tuning process
- Systematic evaluation
- Cost-benefit analysis
- When to fine-tune vs prompt engineer

### Success Criteria

- [ ] 100+ quality training examples
- [ ] All three approaches implemented
- [ ] Rigorous evaluation on 30+ test cases
- [ ] Cost analysis and comparison
- [ ] Written analysis of results
- [ ] Recommendations with justification

---

## Project 5: Full-Stack AI Application

**Objective:** Complete production-ready application combining all skills

### Project Ideas

1. **AI Research Assistant**: Summarize papers, answer questions
2. **Code Documentation Generator**: Auto-generate docs from code
3. **Customer Support Chatbot**: Handle customer inquiries
4. **Content Generation Platform**: Blog posts, product descriptions
5. **Personal AI Assistant**: Calendar, notes, task management

### Technical Stack Example

```
Frontend: Next.js 14 + TypeScript + Tailwind CSS + Shadcn UI
Backend: FastAPI + PostgreSQL + Redis + Celery
AI/ML: OpenAI + Pinecone + LangChain + custom evaluation
DevOps: Docker + Docker Compose + GitHub Actions
Deployment: Vercel (frontend) + Railway (backend)
```

### Must-Have Features

**Authentication & Users:**
- [ ] User registration/login
- [ ] JWT tokens
- [ ] Data isolation per user
- [ ] Usage quotas/limits

**AI Capabilities:**
- [ ] 2+ different AI features
- [ ] RAG or agent system
- [ ] Evaluation tracking
- [ ] Cost monitoring

**Production Ready:**
- [ ] Comprehensive error handling
- [ ] Logging and debugging
- [ ] Rate limiting
- [ ] Input validation
- [ ] Database migrations

**Deployment:**
- [ ] Fully deployed and working
- [ ] Optional custom domain
- [ ] SSL/HTTPS
- [ ] Database backups

### Skills Demonstrated

- Full-stack development
- System design
- Database modeling
- Authentication/authorization
- Production deployment
- Monitoring and observability

### Success Criteria

- [ ] Fully functional end-to-end
- [ ] Working user authentication
- [ ] 2+ distinct AI features
- [ ] Deployed and publicly accessible
- [ ] Comprehensive README with:
  - Architecture diagram
  - Setup instructions
  - API documentation
  - Tech choices explained
- [ ] Demo video or live demo

---

## Portfolio Presentation Guidelines

### GitHub Repository

**Structure:**
```
project/
├── README.md (comprehensive)
├── ARCHITECTURE.md (design decisions)
├── SETUP.md (installation)
├── docs/
│   ├── API.md
│   ├── USER_GUIDE.md
│   └── EVALUATION.md
├── src/
│   ├── backend/
│   ├── frontend/
│   └── evaluation/
├── tests/
├── docker-compose.yml
└── .github/workflows/
```

**README Must Include:**
- What problem does it solve
- Live demo link (if deployed)
- How to install/run locally
- How to use the application
- API documentation
- Technical decisions and tradeoffs
- What I learned
- Future improvements

### Deployment

- All projects should be deployed to internet
- Use platforms like Vercel, Railway, Render
- Share live URLs in README

### Documentation

- Clear setup instructions
- API documentation
- Architecture diagrams
- Example usage
- Troubleshooting

---

## ✅ Learning Checklist

### Project Completion

You've completed Stage 2 projects when you have:

- [ ] **5 substantial projects** (not toy examples)
- [ ] **GitHub portfolio** showing your work
- [ ] **At least 3 deployed** to internet (working URLs)
- [ ] **All tested** with evaluation metrics
- [ ] **Well-documented** READMEs and code
- [ ] **Consistent quality** across projects
- [ ] **Can explain** all design decisions

---

## Next Steps

With a strong portfolio, you're ready for:
- **Stage 3: Advanced AI Engineering** (for senior-level skills)
- **Apply for AI Engineering roles** (junior-mid level)
- **Freelance AI projects** (build professionally)

---

*Last updated: 2025-11-03*
