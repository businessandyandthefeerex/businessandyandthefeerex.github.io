---
layout: page
title: "Reviews"
permalink: /reviews/
---
All our reviews, with the latest on top.

{% assign sorted_posts = site.posts | sort: "date" | reverse %}
{% assign current_year = "" %}
{% assign current_month = "" %}
{% assign first_loop = true %}

{% for post in sorted_posts %}
{% assign post_category = post.category %}
{% if post_category == "Reviews" %}
{% assign post_year = post.date | date: "%Y" %}
{% assign post_month = post.date | date: "%B" %}

{% if post_year != current_year %}
{% unless first_loop %}
</ul>
{% endunless %}
<h4>{{ post_year }}</h4>
{% assign current_year = post_year %}
{% assign current_month = "" %}
{% endif %}

{% if post_month != current_month %}
{% unless first_loop or current_month == "" %}
</ul>
{% endunless %}
<h5>{{ post_month }}</h5>
<ul>
{% assign current_month = post_month %}
{% endif %}

<li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% assign first_loop = false %}

{% if forloop.last %}
</ul>
{% endif %}
{% endif %}
{% endfor %}

