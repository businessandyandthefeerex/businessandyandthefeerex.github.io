---
layout: page
title: Auckland, New Zealand
country: New Zealand
region: Auckland
permalink: /country/new-zealand/auckland/
---
[↑ Go to New Zealand regions](/country/new-zealand/)
<ul>
  {% assign posts = site.posts | where: "region", "Auckland" | where: "country", "New Zealand" %}
  {% assign grouped_posts = posts | group_by: "suburb" %}

  {% assign sorted_grouped_posts = grouped_posts | sort: "name" %}
  {% for group in sorted_grouped_posts %}

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
