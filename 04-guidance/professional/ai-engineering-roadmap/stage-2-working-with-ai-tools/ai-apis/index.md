# 🔗 AI APIs Integration

Master integrating foundation model APIs from major providers. This is your entry into AI application development.

---

## 📚 What You'll Learn

- Comparing commercial AI providers: OpenAI, Anthropic, Google Gemini, and Meta Llama
- Setting up API keys and installing SDKs for multiple providers
- Understanding request structure: messages, roles, temperature, and token parameters
- Token counting and cost estimation for production budgets
- Implementing streaming responses for better user experience
- Handling API errors with retry logic and exponential backoff
- Function calling and tool use for enabling agent behavior
- Multi-provider implementation for flexibility and redundancy
- Cost optimization strategies including caching and batching
- Production-ready error handling, logging, and monitoring

## 🔗 Learning Resources

### AI Provider Documentation
- **OpenAI API Documentation** - Industry standard, most mature ecosystem
- **Anthropic Claude Documentation** - Safety-focused, excellent for reasoning and long context
- **Google Gemini Documentation** - Multimodal capabilities and Google Cloud integration
- **Replicate API Documentation** - Access to Llama and other open-source models

### Related Topics
- **[Prompt Engineering](../prompt-engineering/index.md)** - Master how to write effective prompts once you can call APIs
- **[Cost Optimization](../evaluation-metrics/index.md)** - Track and optimize API costs systematically
- **[Projects](../projects/index.md)** - Build Project 1: Chatbot using these API skills

### Provider Selection Guide

| Need | Best Choice |
|------|-------------|
| Best quality, broad use | GPT-4 (OpenAI) |
| Safe, reasoning, long context | Claude 3 (Anthropic) |
| Cost-sensitive | Llama 3 or GPT-3.5 |
| Multimodal (images) | GPT-4V or Gemini |
| Google Cloud integration | Gemini via Vertex AI |

---

## Overview

Master integrating foundation model APIs from major providers. This is your entry into AI application development.

## AI Providers & When to Use Them

### Commercial Providers

**OpenAI**
- Models: GPT-4 Turbo, GPT-4, GPT-3.5-turbo
- Best for: General purpose, most mature ecosystem
- Cost: Mid-range
- Availability: Excellent, industry standard

**Anthropic (Claude)**
- Models: Claude 3 (Opus, Sonnet, Haiku)
- Best for: Safety, longer context windows, reasoning
- Cost: Mid-range
- Availability: Excellent, growing adoption

**Google Gemini**
- Models: Gemini Pro, Gemini Ultra (via Vertex AI)
- Best for: Google Cloud integration, multimodal
- Cost: Competitive
- Availability: Good, improving

**Meta Llama (via API providers)**
- Models: Llama 2, Llama 3
- Best for: Open-source alternative, good performance
- Cost: Lower via providers like Replicate
- Availability: Growing

## API Fundamentals

### Getting Started

**Step 1: Get API Key**
- Create account with provider
- Generate API key
- Store securely (environment variable)

**Step 2: Install SDK**
```bash
pip install openai    # For OpenAI
pip install anthropic # For Anthropic
pip install google-generativeai  # For Gemini
```

**Step 3: Make First Call**
```python
import openai

response = openai.ChatCompletion.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Hello!"}]
)
print(response.choices[0].message.content)
```

### Request Structure

All APIs follow similar patterns:

```python
response = client.chat.completions.create(
    model="model-name",
    messages=[
        {"role": "system", "content": "You are helpful..."},
        {"role": "user", "content": "User question"}
    ],
    temperature=0.7,
    max_tokens=500
)
```

**Key Parameters**
- `model`: Which model to use
- `messages`: Chat history with roles (system, user, assistant)
- `temperature`: 0-2, controls randomness
- `max_tokens`: Maximum response length
- `top_p`: Alternative to temperature
- `presence_penalty`: Penalize repeated topics

### Understanding Responses

```python
response = {
    "choices": [
        {
            "message": {
                "role": "assistant",
                "content": "The actual response..."
            },
            "finish_reason": "stop"  # or "length", "content_filter"
        }
    ],
    "usage": {
        "prompt_tokens": 10,
        "completion_tokens": 50,
        "total_tokens": 60
    }
}
```

**Track**: Token usage for cost estimation

## Cost Optimization

### Token Counting
- Know your costs upfront
- Use provider's token counter
- Estimate before large batches

### Cost Per Query
```
Cost = (prompt_tokens * prompt_rate + completion_tokens * completion_rate) / 1000
```

### Optimization Strategies
1. **Use cheaper models** when possible (GPT-3.5 vs GPT-4)
2. **Batch requests** instead of streaming
3. **Cache prompts** (prompt caching in newer APIs)
4. **Shorter context** reduces input tokens
5. **Monitor usage** track total spend

## Streaming Responses

**Why Stream**
- Better UX (show response as it arrives)
- Can't use stop_tokens with wait

**Streaming Pattern**
```python
stream = client.chat.completions.create(
    model="gpt-4",
    messages=messages,
    stream=True
)

for chunk in stream:
    print(chunk.choices[0].delta.content, end="", flush=True)
```

## Error Handling

**Common Errors**
- `InvalidRequestError`: Bad request format
- `RateLimitError`: Too many requests
- `AuthenticationError`: Invalid API key
- `Timeout`: Network timeout

**Handling Pattern**
```python
import time
from openai import RateLimitError

for attempt in range(3):  # Retry up to 3 times
    try:
        response = client.chat.completions.create(...)
        return response
    except RateLimitError:
        wait_time = 2 ** attempt  # Exponential backoff
        time.sleep(wait_time)
    except Exception as e:
        print(f"Error: {e}")
        raise
```

## Function Calling / Tool Use

**What It Is**
- LLM can call functions you define
- Enables agent behavior
- Structured outputs

**Example**
```python
tools = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {"type": "string"}
                }
            }
        }
    }
]

response = client.chat.completions.create(
    model="gpt-4",
    messages=messages,
    tools=tools
)
```

## Multi-Provider Implementation

```python
class AIClient:
    def __init__(self, provider="openai"):
        self.provider = provider

    def chat(self, messages, **kwargs):
        if self.provider == "openai":
            return self._openai_chat(messages, **kwargs)
        elif self.provider == "claude":
            return self._claude_chat(messages, **kwargs)
        # Add more providers
```

Benefit: Switch providers without rewriting code

## Common Pitfalls

1. **Not handling rate limits** - APIs have limits
2. **Storing API keys in code** - Use environment variables
3. **Not counting tokens** - Costs accumulate fast
4. **Ignoring error handling** - APIs fail sometimes
5. **No logging** - Can't debug issues later
6. **Inconsistent formatting** - Different providers need different formats

## ✅ Learning Checklist

- [ ] Get API keys for at least 2 providers
- [ ] Make successful API calls
- [ ] Understand token counting
- [ ] Handle API errors gracefully
- [ ] Implement retry logic
- [ ] Stream responses
- [ ] Track API costs
- [ ] Use function calling
- [ ] Compare costs between providers
- [ ] Build wrapper class for APIs
- [ ] Implement multi-provider support

### Production Checklist

- [ ] Secure API key management
- [ ] Error handling and retries
- [ ] Cost monitoring and limits
- [ ] Logging and monitoring
- [ ] Request validation
- [ ] Response parsing
- [ ] Timeout handling
- [ ] Rate limiting
- [ ] Multi-provider support
- [ ] Testing with mocks

---

## Next Steps

1. Get API keys from multiple providers
2. Build simple chatbot with each
3. Compare costs and quality
4. Understand token counting
5. Implement proper error handling
6. Move to [Prompt Engineering](../prompt-engineering/index.md)
7. Build [Project 1: Chatbot](../projects/index.md)

---

*Last updated: 2025-11-03*
