package main

import (
	"html/template"
	"io"
	"net/http"
	"os"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

// TemplateRender strct render
type TemplateRender struct {
	templates *template.Template
}

// Render template
func (t *TemplateRender) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

func main() {
	e := echo.New()
	e.Use(middleware.Logger())
	renderer := &TemplateRender{
		templates: template.Must(template.ParseGlob("views/*.html")),
	}
	e.Renderer = renderer

	e.GET("/", func(c echo.Context) error {
		hostname, err := os.Hostname()
		if err != nil {
			hostname = "unknown"
		}
		return c.Render(http.StatusOK, "top.html", map[string]interface{}{"hostname": hostname})
	})

	e.Logger.Fatal(e.Start(":1323"))
}
