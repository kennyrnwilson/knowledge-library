# ✍️ Prompt Engineering

Master the art and science of writing instructions to get the best outputs from LLMs. Small changes in prompts can dramatically improve results.

---

## 📚 What You'll Learn

- Zero-shot prompting for simple, straightforward tasks
- Few-shot prompting with examples to teach the model your style
- Chain-of-thought (CoT) prompting for complex reasoning tasks
- Role prompting to set specific expertise or tone
- System vs user prompts for setting behavior and specific requests
- Advanced ReAct pattern (Reasoning + Acting) for tasks requiring external information
- Self-consistency techniques for complex reasoning and verification
- Prompt chaining to break complex tasks into manageable steps
- Structured output formatting including JSON and delimiters
- Negative prompting to prevent unwanted behaviors
- Parameter tuning: temperature, top_p, and max_tokens
- Systematic prompt optimization workflow with testing and iteration
- A/B testing prompts on test sets for objective comparison
- Common patterns for classification, summarization, translation, question answering, and extraction

## 🔗 Learning Resources

### Related Topics
- **[AI APIs Integration](../ai-apis/README.md)** - Learn to call APIs before optimizing prompts
- **[RAG Systems](../rag/README.md)** - Combine prompting with retrieval for grounded answers
- **[Evaluation Metrics](../evaluation-metrics/README.md)** - Measure prompt quality systematically
- **[Projects](../projects/README.md)** - Apply prompting skills in Project 1: Chatbot

### Tools for Prompt Development
- **Playground from API providers** - OpenAI, Anthropic, and Google provide interactive playgrounds
- **LLM Studio** - Local testing environment
- **Weights & Biases** - Logging and tracking prompt experiments

### Evaluation Tools
- **LLM-as-Judge** - Using another LLM to evaluate outputs
- **Custom metrics** - Build domain-specific evaluation
- **A/B testing frameworks** - Compare prompt variants systematically

---

## Overview

Prompt engineering is the art and science of writing instructions to get the best outputs from LLMs. Small changes in prompts can dramatically improve results.

## Fundamental Techniques

### 1. Zero-Shot Prompting

**What It Is**: Ask without examples

**Example**:
```
Translate this to French: "Hello, how are you?"
```

**When to Use**: Simple, straightforward tasks

**Pros**:
- Quick
- No example data needed

**Cons**:
- May give inconsistent results
- Less reliable for complex tasks

### 2. Few-Shot Prompting

**What It Is**: Provide examples, then ask

**Example**:
```
Sentiment Classification Examples:
1. "Great movie!" → Positive
2. "Really bad" → Negative
3. "It was okay" → Neutral

Classify: "Absolutely amazing!"
```

**When to Use**: When zero-shot is unreliable

**Pros**:
- Teaches the model your style
- More consistent results

**Cons**:
- Uses more tokens
- Need good examples

### 3. Chain-of-Thought (CoT)

**What It Is**: Ask the model to explain reasoning

**Example**:
```
Think step by step:
1. First, identify...
2. Then, calculate...
3. Finally, conclude...

Problem: ...
```

**When to Use**: Complex reasoning tasks

**Pros**:
- Better accuracy for math/logic
- Shows reasoning

**Cons**:
- Longer responses
- More tokens

### 4. Role Prompting

**What It Is**: Tell the model what role to play

**Example**:
```
You are an expert Python developer with 10 years of experience.
Review this code and suggest improvements:

[code]
```

**When to Use**: When you need specific expertise or tone

### 5. System vs User Prompts

**System Prompt** (Sets overall behavior):
```
You are a helpful, friendly assistant.
Be concise and accurate.
```

**User Prompt** (Specific request):
```
What's the capital of France?
```

**Best Practice**: Use system for general instructions, user for specific tasks

## Advanced Patterns

### ReAct (Reasoning + Acting)

```
Question: What is the population of Canada?

Thought: I need to find current population data.
Action: search "Canada population 2024"
Observation: Canada population is approximately 39 million
Thought: I have the answer now.
Answer: Canada has a population of approximately 39 million.
```

**Use for**: Tasks requiring external information

### Self-Consistency

Ask the same question multiple ways, then consolidate:
```
1. "What is 2+2?"
2. "If I have 2 apples and 2 apples, how many total?"
3. "2 plus 2 equals ?"

Then: "I got [answer1], [answer2], [answer3]. The correct answer is..."
```

**Use for**: Complex reasoning, verification

### Prompt Chaining

Break complex task into steps:
```
Step 1: Summarize the article
Step 2: Extract key points
Step 3: List action items
Step 4: Suggest next steps
```

## Output Formatting

### Structured Output (JSON)

**Request**:
```
Return as JSON:
{
  "name": "",
  "age": 0,
  "city": ""
}

Extract info from: "John is 30 years old and lives in NYC"
```

**Use for**: Parsing structured data

### Using Delimiters

```
Summarize the text between ### markers:

###
This is a long article about...
###

In one sentence:
```

**Use for**: Clear boundaries in complex prompts

### Negative Prompting

```
Do not:
- Include personal opinions
- Make up statistics
- Be verbose
- Use technical jargon

Explain quantum computing to a 10-year-old.
```

**Use for**: Preventing unwanted behaviors

## Parameter Tuning

### Temperature (0-2)

- **0**: Deterministic, same answer every time
- **0.5**: Focused but slightly creative
- **1.0**: Balanced (default)
- **1.5+**: Very creative, may be inaccurate

**Use 0-0.3** for: Facts, translations, consistency
**Use 1.0** for: General conversation
**Use 1.5+** for: Brainstorming, creative writing

### top_p (0-1)

- Controls diversity of token selection
- 0.9 means only consider top 90% probable tokens
- Often preferred over temperature

**Recommended**: Set top_p=0.9, leave temperature=1.0

### max_tokens

- Limits response length
- Useful for cost control
- Be generous enough for complete answer

## Optimization Workflow

### 1. Start Simple
Write the most basic prompt that works

### 2. Test & Measure
- Create test cases
- Score outputs (good/bad)
- Calculate success rate

### 3. Iterate
- Small prompt changes
- Test impact
- Keep what improves score

### 4. A/B Test
Compare two prompts on test set

### 5. Optimize Parameters
Tune temperature, top_p, max_tokens

## Common Patterns & Examples

### Classification

```
Classify the sentiment (Positive/Negative/Neutral):
"{text}"

Sentiment:
```

### Summarization

```
Summarize the following in 2-3 sentences:
"{text}"

Summary:
```

### Translation

```
Translate to {language}:
"{text}"

Translation:
```

### Question Answering

```
Answer based ONLY on the context below. If you don't know, say "I don't know".

Context: "{context}"

Question: {question}

Answer:
```

### Extraction

```
Extract all dates and events from the text:
"{text}"

Dates and Events:
```

## Prompt Engineering Best Practices

1. **Be Specific** - Vague prompts get vague answers
2. **Provide Context** - More context = better answers
3. **Give Examples** - Few-shot helps consistency
4. **Use Delimiters** - Clear structure helps parsing
5. **Specify Format** - JSON, list, paragraph, etc.
6. **Test** - Always verify with multiple cases
7. **Iterate** - Small changes compound
8. **Document** - Save successful prompts

## Common Mistakes

1. **Too Vague** - "Write something" vs "Write a 100-word summary"
2. **Too Long** - More isn't always better
3. **No Examples** - Especially for custom formats
4. **Changing Variables** - Keep prompt fixed, change inputs
5. **Not Testing** - Assume one example works
6. **Over-engineering** - Simple beats complex

## ✅ Learning Checklist

- [ ] Understand zero-shot prompting
- [ ] Try few-shot prompting
- [ ] Use chain-of-thought for reasoning
- [ ] Write system prompts
- [ ] Get JSON structured output
- [ ] Use delimiters effectively
- [ ] Implement negative prompting
- [ ] Tune temperature appropriately
- [ ] Test prompt variations
- [ ] Document your best prompts
- [ ] Build A/B testing
- [ ] Measure quality improvements
- [ ] Understand ReAct pattern
- [ ] Use prompt chaining

---

## Next Steps

1. Master few-shot prompting
2. Learn chain-of-thought
3. Practice optimization iteration
4. Build evaluation datasets
5. Move to [RAG](../rag/README.md) for grounded answers
6. Build [Project 1: Chatbot](../projects/README.md)

---

*Last updated: 2025-11-03*
