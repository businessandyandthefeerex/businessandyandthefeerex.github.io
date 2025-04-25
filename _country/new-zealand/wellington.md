---
layout: page
title: Wellington, New Zealand
region: Wellington
country: New Zealand
permalink: /country/new-zealand/wellington/
---
[↑ Go to New Zealand regions](/country/new-zealand/)
<ul>
  {% assign posts = site.posts | where: "region", "Wellington" | where: "country", "New Zealand" %}
  {% assign grouped_posts = posts | group_by: "suburb" %}

  {% for group in grouped_posts %}
    <h4>{{ group.name }}</h4>

    {% assign rating_groups = group.items | group_by: "rating" %}
    {% assign sorted_rating_groups = rating_groups | sort: "name" %}

    {% for rating_group in sorted_rating_groups reversed %}
      <h5>Rating: {{ rating_group.name }}</h5>
      <ul>
        {% for post in rating_group.items %}
          <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
          </li>
        {% endfor %}
      </ul>
    {% endfor %}
  {% endfor %}
</ul>
