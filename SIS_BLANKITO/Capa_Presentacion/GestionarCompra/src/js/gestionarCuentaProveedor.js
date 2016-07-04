$(function () {
    SetearMenu();
});

function SetearMenu() {
    $(".main-menu li").removeClass("active toggled");
    $("#menu-compra").addClass("active toggled");
    $("#mc-cuepro a").attr("class", "active");
}