#let letter(body) = {
    set list(indent: 1em)
    show list: set text(size: 0.92em)
    show link: underline
    show link: set underline(offset: 3pt)

    set page(
        paper: "us-letter",
        margin: (x: 0.5in, y: 0.5in)
    )

    set text(
        size: 11pt,
        font: "New Computer Modern",
    )

    body
}

#let name_header(name) = {
    set text(size: 2.25em)
    [*#name*]
}

#let header(
    name: "Jake Ryan",
    phone: "123-456-7890",
    email: "jake@su.edu",
    linkedin: "linkedin.com/in/jake",
    site: "github.com/jake",
) = {
    align(center,
        block[
            #name_header(name) \
            #phone |
            #link("mailto:" + email)[#email] |
            #link("https://" + linkedin)[#linkedin] |
            #link("https://" + site)[#site]
        ]
    )
    v(5pt)
}

#let letter_heading(txt) = {
    show heading: set text(size: 0.92em, weight: "regular")

    block[
        = #smallcaps(txt)
        #v(-4pt)
        #line(length: 100%, stroke: 1pt + black)
    ]
}

#let letter_data = yaml("letter.yml")

#let yml_personal(d) = {
    header(
        name: d.name,
        phone: d.phone,
        email: d.email,
        linkedin: d.linkedin,
        site: d.site
    )
}

#let letter_salutation(d) = {
    align(left, {
        h(1fr)
        text(10pt, weight: "light")[#datetime.today(offset:
        auto).display("[month repr:long] [day padding:none], [year]")\ ]

        text(10pt, weight: "regular")[#d.first #d.last\ ]
        text(10pt, weight: "regular")[#d.city, #d.state\ ]
        if d.phone != "" {
            text(10pt, weight: "regular")[#d.phone\ ]
        }
        if d.email != "" {
            text(10pt, weight: "regular")[#d.email\ ]
        }
        v(2pt)
        text(10pt, weight: "regular")[Dear #d.prefix #d.last,\ ]
    })
}

#let letter_body(d) = {
    set par(justify: true, first-line-indent: 2em)
    set text(11pt, weight: "regular")
    for paragraph in d {
        par()[#paragraph\ ]
    }
}

#let letter_signature(d) = {
    v(2pt)
    align(left, {
        text(10pt, weight: "regular")[Sincerely,\ ]
        image("signature.png", alt: d.name, width: 10%)
        text(10pt, weight: "regular")[#d.name]
    })
}

#let yml_letter(data) = {
    show: letter

    yml_personal(data.personal)
    letter_salutation(data.recipient)
    letter_body(data.paragraphs)
    letter_signature(data.personal)
}

#yml_letter(letter_data)
