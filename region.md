---
layout: page
title: Reviews by Region
permalink: /region/
---
All our restaurant reviews listed by region.

{% assign nz_posts = site.categories.reviews | where: "country", "New Zealand" %}
{% assign nz_regions = "" | split: "" %}

{% for post in nz_posts %}
  {% unless nz_regions contains post.region %}
    {% assign nz_regions = nz_regions | push: post.region %}
  {% endunless %}
{% endfor %}

{% assign custom_order = "Northland,Auckland,Waikato,Bay of Plenty,Gisborne,Hawke's Bay,Taranaki,Manawatū-Whanganui,Wellington,Tasman,Nelson,Marlborough,West Coast,Canterbury,Otago,Southland" | split: "," %}

<ul>
  {% for region in custom_order %}
    {% if nz_regions contains region %}
      <li>
        <a href="/country/new-zealand/{{ region | downcase | replace: ' ', '-' }}/">
            {{ region }}
        </a>
      </li>
    {% endif %}
  {% endfor %}
</ul>

<ul>
  {% assign countries = site.categories.reviews | map: 'country' | uniq %}
  
  {% for country in countries %}
    {% if country != "New Zealand" %}
      <li>
        <a href="/country/{{ country | downcase | replace: ' ', '-' }}/">
            {{ country }}
        </a>
      </li>
    {% endif %}
  {% endfor %}
</ul>