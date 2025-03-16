---
layout: page
title: Home
id: home
permalink: /
---

# Cultivating Ideas in My Digital Garden 🌱

**Welcome, fellow explorer!**  
This is my personal knowledge ecosystem where ideas grow, connect, and evolve.

Unlike traditional blogs, this space doesn't follow chronological order — instead, it branches out organically ==as my thoughts develop==.

> Begin your journey with [[Why I started this garden]] or dive into a random note below.

{% include stats.html %}

---

## Cats & Tags

{% assign all_tags = "" | split: "," %}
{% assign all_categories = "" | split: "," %}

{% for note in site.notes %}
  {% assign all_tags = all_tags | concat: note.tags %}
  {% assign all_categories = all_categories | concat: note.categories %}
{% endfor %}

{% assign all_tags = all_tags | uniq %}
{% assign all_categories = all_categories | uniq %}

<ul>
  {% for tag in all_tags %}
    <li><a href="/tags/{{ tag | slugify }}/">{{ tag }}</a></li>
  {% endfor %}
</ul>

<ul>
  {% for category in all_categories %}
    <li><a href="/categories/{{ category | slugify }}/">{{ category }}</a></li>
  {% endfor %}
</ul>

---

## All Notes
<ul>
  {% for note in site.notes %}
    <li>{{ note.title }} - Tags: {{ note.tags | join: ', ' }}</li>
  {% endfor %}
</ul>

---

## Recently updated notes

<ul>
  {% assign recent_notes = site.notes | sort: "last_modified_at_timestamp" | reverse %}
  {% for note in recent_notes limit: 5 %}
    <li>
      {{ note.last_modified_at | date: "%Y-%m-%d" }}<a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
    </li>
  {% endfor %}
</ul>

> [!tip] The mind is not a vessel to be **filled**, but a *fire* to be kindled. 
> — Plutarch
