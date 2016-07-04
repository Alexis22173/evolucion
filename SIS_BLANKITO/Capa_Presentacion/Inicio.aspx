﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="Capa_Presentacion.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $(".main-menu li").removeClass("active toggled");
            $("#menu-inicio").attr("class", "active");
            notify('Bienvenido de nuevo Blankito', 'inverse');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="block-header">
        <h2>Sparkline Charts <small>This plugin generates small inline charts using data supplied either inline in the HTML, or via javascript.</small></h2>

        <ul class="actions">
            <li>
                <a href="#">
                    <i class="md md-trending-up"></i>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="md md-done-all"></i>
                </a>
            </li>
            <li class="dropdown">
                <a href="#" data-toggle="dropdown">
                    <i class="md md-more-vert"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-right">
                    <li>
                        <a href="#">Refresh</a>
                    </li>
                    <li>
                        <a href="#">Manage Widgets</a>
                    </li>
                    <li>
                        <a href="#">Widgets Settings</a>
                    </li>
                </ul>
            </li>
        </ul>

    </div>

    <div class="mini-charts">
        <div class="row">
            <div class="col-sm-3">
                <div class="mini-charts-item bgm-cyan">
                    <div class="clearfix">
                        <div class="chart stats-bar"></div>
                        <div class="count">
                            <small>Website Traffics</small>
                            <h2>987,459</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-lightgreen">
                    <div class="clearfix">
                        <div class="chart stats-bar-2"></div>
                        <div class="count">
                            <small>Website Impressions</small>
                            <h2>356,785K</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-orange">
                    <div class="clearfix">
                        <div class="chart stats-line"></div>
                        <div class="count">
                            <small>Total Sales</small>
                            <h2>$ 458,778</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-bluegray">
                    <div class="clearfix">
                        <div class="chart stats-line-2"></div>
                        <div class="count">
                            <small>Support Tickets</small>
                            <h2>23,856</h2>
                        </div>
                    </div>
                </div>
            </div>


            <div class="col-sm-3">
                <div class="mini-charts-item bgm-teal">
                    <div class="clearfix">
                        <div class="chart chart-pie stats-pie"></div>
                        <div class="count">
                            <small>Percentage</small>
                            <h2>99.87%</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-red">
                    <div class="clearfix">
                        <div class="chart stats-line"></div>
                        <div class="count">
                            <small>Total Sales</small>
                            <h2>$ 458,778</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-blue">
                    <div class="clearfix">
                        <div class="chart chart-pie stats-pie"></div>
                        <div class="count">
                            <small>Percentage</small>
                            <h2>99.87%</h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-3">
                <div class="mini-charts-item bgm-pink">
                    <div class="clearfix">
                        <div class="chart stats-bar"></div>
                        <div class="count">
                            <small>Website Traffics</small>
                            <h2>987,459</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br />
    <br>

    <div class="block-header">
        <h2>EASY PIE CHART <small>Lightweight jQuery plugin to render and animate nice pie charts with the HTML5 canvas element.</small></h2>

        <ul class="actions">
            <li>
                <a href="#">
                    <i class="md md-trending-up"></i>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="md md-done-all"></i>
                </a>
            </li>
            <li class="dropdown">
                <a href="#" data-toggle="dropdown">
                    <i class="md md-more-vert"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-right">
                    <li>
                        <a href="#">Refresh</a>
                    </li>
                    <li>
                        <a href="#">Manage Widgets</a>
                    </li>
                    <li>
                        <a href="#">Widgets Settings</a>
                    </li>
                </ul>
            </li>
        </ul>

    </div>

    <div class="row">
        <div class="col-sm-3">
            <div class="epc-item bgm-pink">
                <div class="easy-pie main-pie" data-percent="45">
                    <div class="percent">45</div>
                    <div class="pie-title">Total Emails Sent</div>
                </div>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="epc-item bgm-orange">
                <div class="easy-pie main-pie" data-percent="88">
                    <div class="percent">88</div>
                    <div class="pie-title">Sold Items</div>
                </div>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="epc-item bgm-green">
                <div class="easy-pie main-pie" data-percent="25">
                    <div class="percent">25</div>
                    <div class="pie-title">Spam Mails</div>
                </div>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="epc-item bgm-purple">
                <div class="easy-pie main-pie" data-percent="89">
                    <div class="percent">89</div>
                    <div class="pie-title">Profit Rate</div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
