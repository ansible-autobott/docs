Book ships with several short codes:

# buttons

```tpl
{{</* button relref="/" [class="..."] */>}}Get Home{{</* /button */>}}
{{</* button href="https://github.com/alex-shpak/hugo-book" */>}}Contribute{{</* /button */>}}
```

# Columns

```html
{{%/* columns [ratio="1:1"] [class="..."] */%}} <!-- begin columns block -->
# Left Content
Lorem markdownum insigne...

<---> <!-- magic separator, between columns -->

# Mid Content
Lorem markdownum insigne...

<---> <!-- magic separator, between columns -->

# Right Content
Lorem markdownum insigne...
{{%/* /columns */%}}
```

# Details 
this is a dropdown

```tpl
{{%/* details "Title" [open] */%}}
## Markdown content
Lorem markdownum insigne...
{{%/* /details */%}}
```
```tpl
{{%/* details title="Title" open=true */%}}
## Markdown content
Lorem markdownum insigne...
{{%/* /details */%}}
```

# Hints

This is a info/warning/danget box

[info|warning|danger]

```tpl
{{% hint info %}}
**Markdown content**  
Lorem markdownum insigne. Olympo signis Delphis! Retexi Nereius nova develat
stringit, frustra Saturnius uteroque inter! Oculis non ritibus Telethusa
{{% /hint %}}
```
# tabs

```tpl
{{</* tabs "id" */>}}
{{%/* tab "MacOS" */%}} # MacOS Content {{%/* /tab */%}}
{{%/* tab "Linux" */%}} # Linux Content {{%/* /tab */%}}
{{%/* tab "Windows" */%}} # Windows Content {{%/* /tab */%}}
{{</* /tabs */>}}
```


# Mermaid Diagrams

check the theme documentation for details

````tpl
```mermaid
stateDiagram-v2
    State1: The state with a note
    note right of State1
        Important information! You can write
        notes.
    end note
    State1 --> State2
    note left of State2 : This is the note to the left.
```
````
