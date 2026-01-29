<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SIMANET_W22R.Default" %>
<%@ Register TagPrefix="uc1" Namespace="SIMANET_W22R.Controles" Assembly="SIMANET_W22R" %>
<%@ Register src="Controles/Header.ascx" tagname="Header" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>NetSuite</title>
    <script src='https://unpkg.com/locomotive-scroll@4.0.6/dist/locomotive-scroll.min.js'></script>
    
    <style>
        .Fondo {
            background-image: url('/Recursos/img/FondoDefault1.jpg');
            background-repeat: no-repeat;
            background-position: center;
            /*background-position-y: bottom;*/
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
    </style>
    
    <style>
        html, body {
            height: 100%;
            background: #eee;
        }

        body {
            overflow: hidden;
        }

        .scroll-animations-example {
            > .scrollsection {
                /*padding: 10vh 10vh 10vh 10vmax;*/
                padding: 2vh 10vh 5vh 2vmax;
                min-width: 550vh;
            }

                > .scrollsection > .item {
                    display: inline-block;
                    position: relative;
                    margin: 0 -30vh 0 3vh;
                }

                    > .scrollsection > .item::before {
                        content: '';
                        display: inline-block;
                        vertical-align: middle;
                        height: 100%;
                    }

                    > .scrollsection > .item.-big {
                        height: 80vh;
                        width: 60vh;
                    }

                        > .scrollsection > .item.-big.-horizontal {
                            height: 60vh;
                            width: 80vh;
                        }

                    > .scrollsection > .item.-normal {
                        height: 60vh;
                        width: 45vh;
                        z-index: 1;
                    }

                        > .scrollsection > .item.-normal.-horizontal {
                            height: 45vh;
                            width: 60vh;
                        }

                        > .scrollsection > .item.-normal:nth-of-type(3n) {
                            bottom: 5vh;
                        }

                        > .scrollsection > .item.-normal:nth-of-type(4n) {
                            bottom: -5vh;
                        }

                    > .scrollsection > .item.-small {
                        height: 40vh;
                        width: 30vh;
                        z-index: 2;
                    }

                        > .scrollsection > .item.-small.-horizontal {
                            height: 30vh;
                            width: 40vh;
                        }

                        > .scrollsection > .item.-small:nth-of-type(3n) {
                            bottom: 13vh;
                        }

                        > .scrollsection > .item.-small:nth-of-type(4n) {
                            bottom: -13vh;
                        }

                    > .scrollsection > .item > .image {
                        height: 100%;
                        width: 100%;
                        position: absolute;
                        top: 0;
                        left: 0;
                        filter: grayscale(1);
                        opacity: 0;
                        pointer-events: none;
                        transform: translateX(0) translateY(0) scale(1);
                        transition: filter .3s ease, opacity 1s ease, transform 1s ease;
                    }

                    > .scrollsection > .item:nth-of-type(4n) > .image {
                        transform: translateX(-30vh) translateY(-30vh) scale(.8);
                        transition-delay: 0;
                    }

                    > .scrollsection > .item:nth-of-type(4n - 1) > .image {
                        transform: translateX(30vh) translateY(30vh) scale(.8);
                        transition-delay: .05s;
                    }

                    > .scrollsection > .item:nth-of-type(4n - 2) > .image {
                        transform: translateX(-30vh) translateY(30vh) scale(.8);
                        transition-delay: .1s;
                    }

                    > .scrollsection > .item:nth-of-type(4n - 3) > .image {
                        transform: translateX(-30vh) translateY(-30vh) scale(.8);
                        transition-delay: .15s;
                    }

                    > .scrollsection > .item > .image.-active {
                        transform: translateX(0) translateY(0) scale(1);
                        opacity: .8;
                        pointer-events: auto;
                        transition: filter .3s ease, opacity 1s ease, transform 1s ease;
                    }

                    > .scrollsection > .item > .image.-clicked {
                        transform: translateX(0) translateY(0) scale(5);
                        opacity: 0;
                        pointer-events: auto;
                        transition: filter .3s ease, opacity 1s ease, transform 1s ease;
                    }

                    > .scrollsection > .item > .image.-active:hover {
                        height: 100%;
                        width: 100%;
                        position: absolute;
                        top: 0;
                        left: 0;
                        filter: grayscale(0);
                        opacity: 1;
                        cursor: pointer;
                    }
        }


        .fake-ui {
            font-size: 0;

            > .logo {
                position: fixed;
                top: 2vh;
                left: 2vh;
                height: 3vh;
                width: 2.5vh;
                border: solid 1vh #999;
            }

            > .nav {
                position: fixed;
                top: 2vh;
                right: 2vh;
            }

                > .nav > .item {
                    background: #999;
                    display: inline-block;
                    height: 2vh;
                    width: 10vh;
                    margin-left: 2vh;
                }

            > .footer {
                position: fixed;
                bottom: 3vh;
                left: 50%;
                transform: translateX(-50%);
                height: 2vh;
                width: 40vh;
                background: #999;
            }
        }
    </style>
</head>
<body class="Fondo">
    <form id="form1" runat="server">
        <uc1:Header ID="Header1" runat="server" />
        
        <div class='scroll-animations-example' data-scroll-container>
            <div id="SliderContent" runat="server" class='scrollsection' data-scroll-section>
            </div>
        </div>
        
        <script>
            class Example {
                constructor(options) {
                    this.root = options.root;

                    this.init();

                    setTimeout(this.showImages.bind(this), 1000);
                }

                init() {
                    this.scroll = new LocomotiveScroll({
                        el: this.root,
                        direction: 'horizontal',
                        smooth: true,
                        lerp: 0.05,
                        tablet: {
                            smooth: true
                        },

                        smartphone: {
                            smooth: true
                        }
                    });

                    this.images = this.root.querySelectorAll('.image');

                    [].forEach.call(this.images, image => {
                        image.addEventListener('click', () => {
                            image.classList.add('-clicked');
                            this.hideImages();
                        });
                    });
                }

                showImages() {
                    [].forEach.call(this.images, image => {
                        image.classList.remove('-clicked');
                        image.classList.add('-active');
                    });
                }

                hideImages() {
                    [].forEach.call(this.images, image => {
                        image.classList.remove('-active');
                    });

                    setTimeout(this.showImages.bind(this), 2000);
                }
            }

            window.addEventListener('DOMContentLoaded', event => {
                const example = new Example({
                    root: document.querySelector('.scroll-animations-example')
                });

            });
        </script>
    </form>
</body>

<script>

    setTimeout(function () {
        var elemStyle = "jqx-menu-item-arrow-right jqx-menu-item-arrow-right-light jqx-icon-arrow-right";
        var collection = document.getElementsByClassName("jqx-menu-item-arrow-right jqx-menu-item-arrow-right-light jqx-icon-arrow-right jqx-icon-arrow-right-light");
        // alert(collection.length);
        for (i = 0; i < collection.length; i++) {
            collection[i].className = elemStyle;
        }
    }, 2000);
</script>
</html>
