# 🧠 Deep Learning Internals & Architecture

Understand how modern LLMs actually work under the hood. This knowledge enables optimization, debugging, and innovation.

---

## 📚 What You'll Learn

- Transformer architecture components: attention mechanism, multi-head attention, positional encodings
- Training dynamics: backpropagation, optimization algorithms, learning rate schedules, gradient clipping
- Advanced architectures: Mixture of Experts (MoE), vision transformers, long-context models, state space models
- Model training techniques: supervised fine-tuning (SFT), RLHF, DPO, Constitutional AI
- Distributed training strategies: data and model parallelism, ZeRO optimization, mixed precision training
- Scaling laws and emergent abilities of large models
- Architecture variants: encoder-only (BERT), decoder-only (GPT), encoder-decoder (T5)

---

## 🔗 Learning Resources

**Prerequisites:**
- [[Stage 2: Working with AI Tools]] - Must understand basic AI concepts
- Strong mathematical foundation (linear algebra, calculus)
- Programming experience with PyTorch or TensorFlow

**Related Areas:**
- [[MLOps & Production Infrastructure]] - Applying this knowledge in production
- [[Inference Optimization & Scaling]] - Optimizing trained models
- [[Advanced Evaluation & Testing]] - Testing model behavior

**Key Papers:**
- "Attention is All You Need" (Vaswani et al., 2017) - Original transformer paper
- "BERT: Pre-training of Deep Bidirectional Transformers" - Encoder architecture
- "Language Models are Unsupervised Multitask Learners" (GPT-2) - Decoder architecture
- "Efficient Transformers" survey - Modern optimizations

**Courses:**
- Stanford CS224N (NLP Deep Learning)
- Fast.ai (Practical deep learning)
- Andrej Karpathy's "Neural Networks: Zero to Hero"

---

## Core Topics

### Transformer Architecture

**What Is a Transformer?**
- Introduced in 2017 ("Attention is All You Need" paper)
- Foundation of all modern LLMs
- Based on attention mechanism instead of RNNs
- Parallelizable and efficient

**Key Components**

1. **Attention Mechanism**
   - Query (what I'm looking for)
   - Key (what's available)
   - Value (the information)
   - Scaled dot-product attention
   - Softmax over keys
   - Weighted sum of values

2. **Multi-Head Attention**
   - Multiple attention heads in parallel
   - Each head learns different patterns
   - Heads attend to different positions
   - Combine all heads

3. **Positional Encodings**
   - Transformers have no inherent position sense
   - Add position information to embeddings
   - Absolute: Pre-computed for each position
   - Relative: Learned position relationships
   - Modern: ALiBi, Rotary (RoPE), T5 Bias

4. **Feed-Forward Networks**
   - Simple MLP in each layer
   - Expand → ReLU → Compress
   - Same across tokens, different per layer
   - Where "knowledge" is stored

5. **Layer Normalization**
   - Stabilize training
   - Normalize to zero mean, unit variance
   - Pre-norm vs post-norm
   - Critical for deep networks

6. **Residual Connections**
   - Skip connections around layers
   - Enable very deep networks
   - Gradient flow improvement
   - Information preservation

**Architecture Variants**

| Type | Example | Description |
|------|---------|-------------|
| Encoder-only | BERT | Bidirectional context |
| Decoder-only | GPT | Causal (left-to-right only) |
| Encoder-Decoder | T5, BART | Both capabilities |

### Training Dynamics

**Backpropagation**
- Forward pass: Compute loss
- Backward pass: Compute gradients
- Update weights: Gradient descent
- Chain rule for derivatives

**Optimization Algorithms**
- **SGD**: Simple, slow
- **Adam**: Adaptive learning rates (most common)
- **AdamW**: Adam with weight decay (better)
- **SGD + Momentum**: Fast convergence

**Learning Rate Schedules**
- **Constant**: Fixed learning rate
- **Linear warmup**: Ramp up gradually (important!)
- **Cosine annealing**: Decrease smoothly
- **Step decay**: Drop every N steps
- **Exponential decay**: Exponential decrease

**Gradient Clipping**
- Prevent exploding gradients
- Common max norm: 1.0
- Essential for stability

**Batch Normalization vs Layer Normalization**
- Batch Norm: Normalize across batch dimension
- Layer Norm: Normalize across feature dimension
- Transformers use Layer Norm (works better)
- Batch size independence

**Loss Functions**
- Cross-entropy (classification)
- Contrastive loss (embeddings)
- Language modeling loss (next token prediction)

### Advanced Architectures

**Mixture of Experts (MoE)**
- Multiple expert networks
- Router selects which experts to use
- Only activates subset of parameters
- Load balancing challenges
- Used in: Mixtral, GLaM, Switch Transformers

**Retrieval-Based Models**
- Augment with external data
- Retrieve relevant context
- Generate with context
- More factual, up-to-date

**Vision Transformers (ViT)**
- Apply transformers to images
- Patch embedding (split image into patches)
- Treat patches like tokens
- Effective for vision tasks

**Long-Context Models**
- Extend context length beyond 4k tokens
- Techniques:
  - Relative position encodings
  - ALiBi (Attention with Linear Biases)
  - Sparse attention
  - Sliding window attention
  - Recurrent attention

**State Space Models (SSM)**
- Alternative to attention (e.g., Mamba)
- Linear complexity vs quadratic
- Promising for efficiency
- Newer architecture

### Model Training (Conceptual)

**Pre-training**
- Objective: Predict next token
- Data: Massive text corpus
- Goal: Learn general knowledge
- Results: Foundation model

**Supervised Fine-Tuning (SFT)**
- Objective: Follow instructions
- Data: High-quality instruction pairs
- Goal: Make model helpful
- Results: More useful model

**RLHF (Reinforcement Learning from Human Feedback)**
- Step 1: Train reward model (human preferences)
- Step 2: Use PPO (Proximal Policy Optimization)
- Step 3: Optimize for human-preferred responses
- Used in: ChatGPT, Claude, InstructGPT

**Direct Preference Optimization (DPO)**
- Simpler than RLHF
- No separate reward model
- Direct preference learning
- Emerging technique

**Constitutional AI (CAI)**
- Align with constitution of principles
- Red team to find issues
- Learn from violations
- Scalable approach

**Distributed Training**
- Data parallelism: Split data across GPUs
- Model parallelism: Split model across GPUs
- Pipeline parallelism: Split by layers
- ZeRO optimization: Clever memory optimization

**Mixed Precision Training**
- FP32: Full precision (slow)
- FP16: Half precision (2x faster, unstable)
- BF16: Brain float (stable, faster)
- Common: Mix FP32 and FP16 strategically

---

## ✅ Learning Checklist

- [ ] Understand attention mechanism mathematics
- [ ] Trace forward pass through transformer
- [ ] Trace backward pass (backprop)
- [ ] Explain why positional encoding is needed
- [ ] Understand multi-head attention purpose
- [ ] Know difference between architectures
- [ ] Understand optimization algorithms
- [ ] Know learning rate schedules
- [ ] Understand RLHF pipeline
- [ ] Know what's differentiable
- [ ] Understand computational complexity
- [ ] Know memory requirements
- [ ] Understand scaling laws

## Intuition & Insights

**Why Transformers Work**
- Attention attends to relevant positions
- Parallel processing (efficient)
- Deep networks learn hierarchies
- Works for both NLP and vision

**The Role of Scale**
- More parameters → Better performance
- Scaling laws are predictable
- Compute becomes bottleneck
- But: Not linear improvement

**Emergent Abilities**
- Chain-of-thought at sufficient scale
- In-context learning
- Few-shot adaptation
- Not fully understood

## Limitations & Failure Cases

- **Hallucination**: Making up facts
- **Context confusion**: Losing info in long contexts
- **Token bias**: Some tokens more likely (position, etc.)
- **Mathematical errors**: Not perfect at arithmetic
- **Common sense**: Sometimes lacks reasoning
- **Explainability**: Hard to understand decisions

## Next Steps

1. Read "Attention is All You Need" paper
2. Implement attention from scratch (numpy)
3. Study existing transformer code
4. Understand modern variants (MoE, long-context)
5. Learn about RLHF
6. Move to [[MLOps & Infrastructure]]

---

*Last updated: 2025-11-03*
