# 📊 2.5 Evaluation Metrics

Learn to measure, evaluate, and systematically improve the quality of your AI applications with proper metrics and testing frameworks.

---

## 📚 What You'll Learn

- Classification and information retrieval metrics for traditional ML tasks
- LLM-specific evaluation metrics (faithfulness, relevance, completeness, coherence)
- LLM-as-Judge automated evaluation techniques and best practices
- RAG-specific metrics for retrieval quality and answer faithfulness
- Building and maintaining evaluation datasets for systematic testing
- A/B testing methodology for comparing AI system variants
- Cost and performance tracking for production optimization
- Continuous improvement workflows for iterative system enhancement

---

## 🔗 Learning Resources

**Related Areas:**
- [[Prompt Engineering]] - Better prompts require proper evaluation
- [[RAG Applications]] - RAG systems need specialized metrics
- [[AI Agents]] - Agent evaluation requires multi-step assessment
- [[Production Deployment]] - Metrics critical for production monitoring

**Key Concepts:**
- Traditional ML metrics (precision, recall, F1, NDCG)
- LLM quality dimensions (faithfulness, relevance, completeness)
- Automated evaluation with LLM-as-Judge
- Test set creation and maintenance
- Statistical significance in A/B testing

---

## Why Evaluation is Critical

**Key Principle:** "What gets measured gets improved."

Without evaluation, you can't tell if changes improve or harm your application. You can't compare objectively, catch regressions, justify decisions, or optimize costs.

---

## Types of Metrics

### Quality Metrics
- Output correctness and accuracy
- Relevance to user query
- Completeness of response
- Hallucinations or factual errors

### Performance Metrics
- Latency (response time)
- Throughput (requests per second)
- Token usage efficiency

### Cost Metrics
- Cost per request
- Total token usage
- Infrastructure costs

### Reliability Metrics
- Failure rate
- Error handling
- Edge case handling
- Consistency across runs

---

## Traditional ML Metrics (Still Relevant)

### Classification Metrics

**Accuracy** = Correct / Total

**Precision** = True Positives / (True Positives + False Positives)
- "Of predicted positives, how many are correct?"

**Recall** = True Positives / (True Positives + False Negatives)
- "Of actual positives, how many did we catch?"

**F1 Score** = 2 × (Precision × Recall) / (Precision + Recall)
- Harmonic mean of precision and recall

**Example - Spam Detection:**
```
              Predicted Spam  Predicted Not Spam
Actual Spam         90                10
Actual Not Spam      5               895

Accuracy = 985/1000 = 98.5%
Precision = 90/95 = 94.7%
Recall = 90/100 = 90%
```

### Information Retrieval Metrics

**Precision@K** = Relevant results in top K / K
- "Of first K results, how many are relevant?"

**Recall@K** = Relevant results in top K / Total relevant
- "Of all relevant results, what fraction appears in top K?"

**Mean Reciprocal Rank (MRR)** = Average of (1/rank of first relevant)
- "How many items until we find relevant result?"

**NDCG** (Normalized Discounted Cumulative Gain)
- Considers ranking order
- Perfect ranking = 1.0, worst = 0.0

---

## LLM-Specific Evaluation Metrics

### Faithfulness/Groundedness

**Definition:** Output is factually correct and grounded in source material.

**5-Point Rubric:**
- 5: Completely accurate, all claims supported
- 4: Mostly accurate, minor errors
- 3: Mixed accuracy, some unsupported claims
- 2: Multiple inaccuracies
- 1: Mostly hallucinated or incorrect

### Relevance

**Definition:** Output directly addresses the user's question.

**5-Point Rubric:**
- 5: Perfect match to query
- 4: Mostly relevant with minor irrelevant parts
- 3: Somewhat relevant but missing key aspects
- 2: Tangentially related
- 1: Completely irrelevant

### Completeness

**Definition:** Output answers all aspects of the question.

**Questions to ask:**
- Does it answer the main question?
- Does it address sub-questions?
- Are examples provided?
- Is context sufficient?

### Coherence

**Definition:** Output is well-structured and easy to follow.

**Check:**
- Logical flow of ideas
- Clear transitions
- Proper organization
- No contradictions

### Consistency

**Definition:** Same query gives consistent responses.

```python
def test_consistency(query, n_runs=10):
    responses = []
    for _ in range(n_runs):
        response = llm.generate(query)
        responses.append(response)

    # Check if responses are similar
    unique_responses = len(set(responses))
    consistency = 1 - (unique_responses / n_runs)
    return consistency

# Test
consistency = test_consistency("What is AI?")
print(f"Consistency: {consistency * 100}%")
```

---

## LLM-as-Judge: Automated Evaluation

Using AI to evaluate AI outputs is practical and scalable.

### Basic Implementation

```python
def evaluate_response(question, response, rubric):
    evaluation_prompt = f"""
    Evaluate this response on a scale of 1-5.

    Question: {question}
    Response: {response}

    Evaluation Criteria:
    {rubric}

    Provide:
    1. Score (1-5)
    2. Justification
    3. Specific improvements

    Return as JSON.
    """

    evaluation = llm.generate(evaluation_prompt)
    return json.loads(evaluation)
```

### Best Practices

1. **Use stronger model to judge weaker ones**
   - GPT-4 judges GPT-3.5 outputs
   - Claude 3.5 judges smaller models

2. **Provide clear rubrics**
   - Be specific about what you're measuring
   - Give examples of good/bad responses

3. **Request structured output**
   - Ask for JSON for easy parsing
   - Request reasoning, not just scores

4. **Ask for justification**
   - "Why did you give this score?"
   - Makes evaluation transparent

5. **Validate against human judgment**
   - Have humans evaluate subset
   - Compare with LLM-as-Judge scores
   - Adjust rubrics if misaligned

---

## RAG-Specific Evaluation

### Retrieval Quality

**Precision@K:**
```python
def precision_at_k(retrieved, relevant, k=5):
    retrieved_k = retrieved[:k]
    correct = len(set(retrieved_k) & set(relevant))
    return correct / k
```

**Recall@K:**
```python
def recall_at_k(retrieved, relevant, k=5):
    retrieved_k = retrieved[:k]
    correct = len(set(retrieved_k) & set(relevant))
    return correct / len(relevant)
```

**Mean Reciprocal Rank:**
```python
def mrr(retrieved, relevant):
    for i, doc in enumerate(retrieved):
        if doc in relevant:
            return 1 / (i + 1)
    return 0
```

### Context Relevance

Check if retrieved documents actually answer the question.

```python
def evaluate_context_relevance(query, contexts):
    eval_prompt = f"""
    Are these contexts relevant to answer: "{query}"?

    Contexts:
    {contexts}

    Score 1-5 and explain.
    """
    score = llm.evaluate(eval_prompt)
    return score
```

### Answer Faithfulness

Check if answer is grounded in retrieved documents (no hallucinations).

```python
def evaluate_faithfulness(contexts, answer):
    eval_prompt = f"""
    Is this answer supported by the contexts?

    Contexts:
    {contexts}

    Answer:
    {answer}

    Score 1-5 and identify any unsupported claims.
    """
    return llm.evaluate(eval_prompt)
```

---

## Building Evaluation Datasets

### Methods

**1. Collect Real User Queries**
- Use actual questions users ask
- Most representative
- Requires real application traffic

**2. Generate Synthetic Test Cases**
```python
def generate_test_cases(domain, n=50):
    prompt = f"""
    Generate {n} diverse test questions for {domain}.
    Return as JSON list.
    """
    return llm.generate(prompt)
```

**3. Manual Curation**
- Hand-select diverse examples
- Ensure edge cases covered
- Create ground truth

### Test Set Requirements

**Size:**
- Start small: 20-50 examples
- Grow to: 100+ for robust metrics
- Ideally: 200+ for statistical significance

**Diversity:**
- Different query types
- Various difficulty levels
- Edge cases
- Multiple languages/contexts

**Ground Truth:**
- Document correct answers
- Provide source material
- Be explicit about expectations

**Maintenance:**
- Update regularly with new patterns
- Remove outdated test cases
- Track performance over time

---

## A/B Testing & Experimentation

### What to A/B Test

- Different prompts (improve instruction clarity)
- Different models (GPT-4 vs Claude)
- Chunk sizes in RAG (128 vs 512 tokens)
- Retrieval strategies (BM25 vs semantic)
- Temperature settings (0.0 vs 0.7)

### Implementation

```python
class ABTest:
    def __init__(self, test_set, metric_fn):
        self.test_set = test_set
        self.metric_fn = metric_fn

    def compare(self, variant_a, variant_b):
        results_a = []
        results_b = []

        for test in self.test_set:
            result_a = variant_a(test)
            result_b = variant_b(test)

            results_a.append(self.metric_fn(result_a))
            results_b.append(self.metric_fn(result_b))

        avg_a = sum(results_a) / len(results_a)
        avg_b = sum(results_b) / len(results_b)

        return {
            'variant_a': avg_a,
            'variant_b': avg_b,
            'improvement': (avg_b - avg_a) / avg_a * 100
        }

# Usage
test = ABTest(eval_dataset, lambda x: evaluate(x)['score'])
results = test.compare(prompt_v1, prompt_v2)
```

---

## Cost & Performance Tracking

### Cost Tracking

```python
class CostTracker:
    pricing = {
        'gpt-4': 0.03 / 1000,  # $0.03 per 1k tokens
        'gpt-3.5': 0.0005 / 1000,
        'claude': 0.01 / 1000,
    }

    def calculate_cost(self, model, tokens):
        return tokens * self.pricing[model]

    def track_request(self, model, input_tokens, output_tokens):
        total = input_tokens + output_tokens
        cost = self.calculate_cost(model, total)
        return cost
```

### Latency Tracking

```python
import time
from collections import defaultdict

class LatencyTracker:
    def __init__(self):
        self.latencies = defaultdict(list)

    def measure_request(self, model, func):
        start = time.time()
        result = func()
        latency = time.time() - start

        self.latencies[model].append(latency)
        return result

    def get_stats(self, model):
        times = self.latencies[model]
        return {
            'avg': sum(times) / len(times),
            'p95': sorted(times)[int(len(times) * 0.95)],
            'p99': sorted(times)[int(len(times) * 0.99)],
        }
```

---

## Continuous Improvement

**Workflow:**
1. Establish baseline metrics
2. A/B test improvements
3. Measure impact
4. Roll out winner
5. Monitor regressions
6. Iterate

---

## ✅ Learning Checklist

- [ ] Understand different metric types
- [ ] Implement classification metrics
- [ ] Calculate RAG metrics
- [ ] Use LLM-as-judge
- [ ] Build evaluation dataset
- [ ] Run A/B tests
- [ ] Track costs and latency
- [ ] Create evaluation dashboard

---

## Project: LLM Evaluation Framework

Build a comprehensive system that:
- Runs evaluation dataset through application
- Evaluates with multiple metrics
- Compares configurations
- Generates detailed report with visualizations
- Tracks metrics over time

---

*Last updated: 2025-11-03*
