const router = require("express").Router();
const mainCon = require("../controller/controller");
const multer = require('multer');




const islogin = (req, res, next) => {
    if (!req.session.user) {
        res.redirect("/login");
    } else {
        next();
    }
};


const isloginAdmin = (req, res, next) => {
    if (!req.session.admin) {
        res.redirect("/login");
    } else {
        next();
    }
};


router.get("/", mainCon.getIndex);

router.get("/index", (req, res) => {
    res.redirect("/");
});

router.get("/login", (req, res) => {
    res.render("login");
});



router.get("/logout", (req, res) => {
    req.session.destroy();
    res.redirect("/");
});
router.post("/login", mainCon.postlogin);


router.post("/livesearch", mainCon.liveSearch);




const storage = multer.diskStorage({

    destination: function (req, file, cb) {
        cb(null, 'public/postImages')
    },
    filename: function (req, file, cb) {

        cb(null, file.originalname)

    }
});

const upload = multer({ storage: storage });


router.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    next();
});



//user
router.use("/userIndex", islogin);
router.get("/userIndex", mainCon.getUserIndex);

router.get("/createBlog", mainCon.createBlog);
router.post("/createBlog", upload.single('picture'), mainCon.userPostBlog);

module.exports = router;