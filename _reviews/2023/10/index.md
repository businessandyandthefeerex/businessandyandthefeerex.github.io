---
layout: page
title: "Reviews from October 2023"
permalink: /reviews/2023/10/
year: 2023
month: 10
---
[↑ Go to 2023](/reviews/2023/)

{% assign this_year = page.year | plus: 0 %}
{% assign this_month = page.month | plus: 0 %}
<ul>
    {% for post in site.posts %}
        {% assign review_year = post.date | date: "%Y" | plus: 0 %}
        {% assign review_month = post.date | date: "%m" | plus: 0 %}
        {% if review_year == this_year and review_month == this_month %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
