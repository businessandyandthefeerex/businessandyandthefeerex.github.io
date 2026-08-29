---
layout: page
title: Stewart Island, New Zealand
country: New Zealand
region: Stewart Island
permalink: /country/new-zealand/stewart-island/
---
[↑ Go to New Zealand regions](/country/new-zealand/)

{% assign posts = site.posts | where: "region", "Stewart Island" | where: "country", "New Zealand" %}
{% assign city_groups = posts | group_by: "city" %}
{% assign sorted_city_groups = city_groups | sort: "name" %}

{% for city_group in sorted_city_groups %}
  {% assign city_slug = city_group.name | downcase | slugify %}
  {% if city_group.name != "" %}
    <h3><a href="/country/new-zealand/stewart-island/{{ city_slug }}" style="color: var(--heading-color);">{{ city_group.name }}</a></h3>
  {% else %}
    <h3>Unspecified city</h3>
  {% endif %}

  {% assign suburb_groups = city_group.items | group_by: "suburb" %}
  {% assign sorted_suburb_groups = suburb_groups | sort: "name" %}

  {% for group in sorted_suburb_groups %}
    {% assign suburb_slug = group.name | downcase | slugify %}
    {% if group.name != "" %}
      <h4><a href="/country/new-zealand/stewart-island/{{ suburb_slug }}" style="color: var(--heading-color);">{{ group.name }}</a></h4>
    {% else %}
      <h4>Unspecified suburb</h4>
    {% endif %}

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
{% endfor %}
