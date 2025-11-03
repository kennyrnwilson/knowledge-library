# 🧠 Pre-trained Models

Navigate the ecosystem of pre-trained AI models and learn when to use open-source vs commercial models for your applications.

---

## 📚 What You'll Learn

- Commercial vs open-source model tradeoffs (performance, cost, privacy, customization)
- Top commercial models: GPT-4, Claude, Gemini, and their specific use cases
- Open-source model landscape: LLaMA, Mistral, Mixtral, Phi, Gemma, Code LLaMA
- Understanding model sizes and their performance implications (1B to 405B+ parameters)
- Mixture of Experts (MoE) architecture and its benefits
- Navigating the HuggingFace ecosystem and reading model cards
- Using HuggingFace pipelines and transformers library
- Task-specific models for classification, NER, translation, embedding, and code
- Model selection framework based on budget, privacy, performance, and latency requirements
- Running models locally with Ollama, LM Studio, vLLM, and HuggingFace
- Quantization fundamentals: FP32, FP16, INT8, INT4 for memory optimization
- Using quantized models with BitsAndBytes
- When to choose fine-tuning vs prompt engineering vs model selection

## 🔗 Learning Resources

### Official Documentation
- **[HuggingFace Hub](https://huggingface.co/models)** - Central repository for pre-trained models
- **[Transformers Library](https://huggingface.co/docs/transformers/)** - Using models programmatically
- **[Ollama](https://ollama.ai)** - Easiest way to run models locally
- **[vLLM](https://github.com/vLLM-project/vLLM)** - High-performance model serving

### Model Leaderboards
- **[LMSYS Chatbot Arena](https://huggingface.co/spaces/lmsys/chatbot-arena-leaderboard)** - Community-driven model rankings
- **[Open LLM Leaderboard](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard)** - Benchmark scores

### Related Topics
- **[AI APIs Integration](../ai-apis/index.md)** - Using commercial models via APIs
- **[RAG Systems](../rag/index.md)** - Combining models with retrieval
- **[Evaluation Metrics](../evaluation-metrics/index.md)** - Comparing model performance objectively
- **[Projects](../projects/index.md)** - Build Project 4: Model Comparison

### Articles & Guides
- **Open Source LLM Guide** - Comprehensive overview of available models
- **Running LLMs on Consumer Hardware** - Practical quantization guide
- **Small Language Models Explained** - When smaller is better

---

## Overview

You don't need to train models from scratch. Pre-trained models are production-ready and can be adapted to your use case through prompting or fine-tuning.

## Commercial vs Open-Source Models

### Commercial Models (API-Based)

**Advantages:**
- State-of-the-art performance
- Constantly updated by provider
- No infrastructure management
- Excellent documentation
- Production-ready reliability

**Disadvantages:**
- Ongoing API costs
- Privacy concerns (data sent to provider)
- Rate limits
- Vendor lock-in
- Limited customization

**Top Commercial Models:**

| Model | Provider | Best For | Cost |
|-------|----------|----------|------|
| GPT-4 / GPT-4 Turbo | OpenAI | Complex reasoning, coding | $$$ |
| GPT-3.5 Turbo | OpenAI | General tasks, cost-effective | $ |
| Claude 3.5 Sonnet | Anthropic | Long context, analysis | $$ |
| Claude 3 Opus | Anthropic | Highest quality tasks | $$$ |
| Gemini Pro | Google | Multimodal, Google integration | $$ |
| Command R+ | Cohere | Enterprise RAG, multilingual | $$ |

### Open-Source Models (Self-Hosted)

**Advantages:**
- Complete data privacy
- No ongoing API costs
- Extensive fine-tuning capability
- No rate limits
- Offline capability

**Disadvantages:**
- Require GPU infrastructure
- Technical expertise needed
- Lower performance than largest models
- Maintenance responsibility
- Slower inference

**Top Open-Source Models:**

| Model | Parameters | Best For | License |
|-------|-----------|----------|---------|
| LLaMA 3.1 (Meta) | 8B - 405B | General purpose, instruction following | Custom (permissive) |
| Mistral 7B | 7B | Fast, efficient, good quality | Apache 2.0 |
| Mixtral 8x7B | 47B (MoE) | High performance, reasonable size | Apache 2.0 |
| Phi-3 (Microsoft) | 3.8B - 14B | Small but capable | MIT |
| Gemma (Google) | 2B - 7B | Efficient, lightweight | Custom (permissive) |
| Code LLaMA | 7B - 34B | Code generation and understanding | Custom (permissive) |

## Understanding Model Sizes & Performance

**Model Size Categories:**

- **1-3B Parameters**: Simple tasks, extremely fast, can run on CPU
- **7-13B Parameters**: Sweet spot for many tasks, runs on consumer GPUs
- **30-70B Parameters**: High quality output, needs powerful GPUs or multi-GPU setup
- **100B+ Parameters**: Highest quality, requires significant infrastructure

**Mixture of Experts (MoE):**
- Some models use sparse experts (activate only relevant parameters)
- Example: Mixtral 8x7B = 47B total, but only ~13B activated per request
- Benefits: High quality with reasonable inference costs

## The HuggingFace Ecosystem

HuggingFace is the central hub for open-source models.

### Finding the Right Model

1. Visit [huggingface.co/models](https://huggingface.co/models)
2. Filter by task (text generation, classification, etc.)
3. Sort by downloads or trending
4. Read model card for details

### Reading Model Cards

Every HuggingFace model has a card showing:
- **Intended use**: What it's designed for
- **Training data**: What it was trained on
- **Limitations**: What it can't do well
- **Ethical considerations**: Bias, safety concerns
- **Performance metrics**: How it performs on benchmarks

### Using Models (Simple Way)

```python
from transformers import pipeline

# Load model with one line
generator = pipeline('text-generation', model='mistralai/Mistral-7B')

# Generate text
result = generator("The future of AI", max_length=100)
print(result)
```

### Loading Models for Custom Use

```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model_name = "meta-llama/Llama-3.1-8B"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

# Use model
inputs = tokenizer("Hello, how are you?", return_tensors="pt")
outputs = model.generate(**inputs, max_length=100)
print(tokenizer.decode(outputs[0]))
```

## Task-Specific Models

For specific tasks, specialized models often outperform general LLMs.

**Text Classification:**
- BERT, RoBERTa, DistilBERT
- Small, fast, accurate
- Great for sentiment, intent classification

**Named Entity Recognition (NER):**
- spaCy models
- BERT-based NER models
- Extract people, organizations, locations

**Translation:**
- NLLB (No Language Left Behind)
- MarianMT
- M2M-100 (many-to-many)

**Embedding Models:**
- sentence-transformers
- E5 models
- BGE (BAAI General Embeddings)
- Used for similarity search, RAG

**Code Models:**
- Code LLaMA
- StarCoder
- CodeGen
- Specialized for programming

## Model Selection Framework

**Decision Tree for Choosing Models:**

1. **What's your budget and privacy?**
   - Low cost, don't care about privacy → Use API (GPT-3.5)
   - High cost, need privacy → Use open-source locally

2. **What's your performance requirement?**
   - Need best performance → Claude/GPT-4
   - Need good performance on budget → Mistral/LLaMA

3. **What's your latency requirement?**
   - Need <100ms → Use small model or commercial API
   - Can wait 1-2s → Larger local models work

4. **Can you fine-tune?**
   - Yes, specialized task → Fine-tune small model
   - No, or general task → Use pre-trained large model

5. **Do you need offline?**
   - Yes → Must use local model
   - No → Can use API

## Running Models Locally

### Ollama (Easiest)

```bash
# Install from ollama.ai
# Run a model:
ollama run mistral

# Use from Python:
import requests
import json

response = requests.post('http://localhost:11434/api/generate',
    json={'model': 'mistral', 'prompt': 'Hello!'})
print(response.json()['response'])
```

### LM Studio

- GUI application for running models
- Download models from HuggingFace
- No command line needed
- Good for beginners

### vLLM (Production)

```python
from vllm import LLM

model = LLM("meta-llama/Llama-2-7b-hf")
outputs = model.generate(["Hello"])
print(outputs)
```

### HuggingFace Transformers (Flexible)

```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model = AutoModelForCausalLM.from_pretrained("mistralai/Mistral-7B")
tokenizer = AutoTokenizer.from_pretrained("mistralai/Mistral-7B")

inputs = tokenizer("Hello", return_tensors="pt")
outputs = model.generate(**inputs)
```

## Quantization & Optimization

Quantization reduces model size and speeds up inference.

**Precision Levels:**
- **FP32**: Full precision (large, slow)
- **FP16**: Half precision (faster, works well)
- **INT8**: 8-bit integer (much smaller)
- **INT4**: 4-bit integer (tiny, minimal quality loss)

**Example - Memory Requirements:**
- LLaMA 3.1 70B model in different formats:
  - FP32: ~140 GB memory needed
  - FP16: ~70 GB memory needed
  - INT8: ~35 GB memory needed
  - INT4: ~17 GB memory needed

**Using Quantized Models:**

```python
from transformers import AutoModelForCausalLM, BitsAndBytesConfig

# 4-bit quantization
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype="float16",
)

model = AutoModelForCausalLM.from_pretrained(
    "meta-llama/Llama-2-70b",
    quantization_config=bnb_config,
    device_map="auto"
)
```

## ✅ Learning Checklist

- [ ] Understand commercial vs open-source tradeoffs
- [ ] Know top 3-4 models in each category
- [ ] Navigate HuggingFace Model Hub
- [ ] Run a model locally (Ollama or Transformers)
- [ ] Load and use custom model
- [ ] Understand quantization concepts
- [ ] Choose right model for your use case
- [ ] Compare cost/performance/latency tradeoffs

### Project: Model Comparison Dashboard

Build a dashboard that:
1. Runs same prompt through 3+ commercial + 2+ local models
2. Compares outputs side-by-side
3. Measures response time
4. Calculates cost
5. Displays quality metrics

This demonstrates deep understanding of model selection.

---

## Next Steps

1. Explore HuggingFace Model Hub
2. Run Ollama locally with Mistral
3. Compare outputs from different models
4. Build model comparison project
5. Move to [Evaluation Metrics](../evaluation-metrics/index.md)

---

*Last updated: 2025-11-03*
