const con = require("../database/connection.js");
const flash = require("express-flash");
const argon2 = require("argon2");
const striptags = require('striptags');






exports.getIndex = (req, res) => {

    const sql = "SELECT p.*, c.name AS `category`, COALESCE(SUM(v.plusone), 0) AS totalView FROM post_tbl p INNER JOIN category_tbl c ON p.category_id = c.id LEFT JOIN views v ON p.id = v.postid WHERE p.status = 1 AND p.`delete_flag` = 0 GROUP BY p.id ORDER BY totalView desc LIMIT 3 ";
    con.query(sql, (err, blogs) => {
        if (err) {
            res.send(err.message);
            return;
        }
        res.render("index", { title: "Home", blogs, stripTags: striptags });
    });
};

exports.liveSearch = (req, res) => {
    const search = req.body.query;
    const sql = "SELECT p.*, c.name AS `category`, COALESCE(SUM(v.plusone), 0) AS totalView FROM  post_tbl p INNER JOIN category_tbl c ON p.category_id = c.id LEFT JOIN views v ON p.id = v.postid WHERE p.status = 1 AND p.`delete_flag` = 0 AND p.title LIKE ? GROUP BY p.id ORDER BY totalView DESC";
    con.query(sql, ['%' + search + '%'], (err, blogs) => {
        if (err) {
            res.send(err.message);
            return;
        }
        res.render("livesearch", { blogs, stripTags: striptags });
    });
};





exports.postlogin = (req, res) => {
    const email = req.body.email;
    const password = req.body.password;
    let alert = "";
    const sql = "SELECT * FROM user_tbl WHERE username=?";
    con.query(sql, [email], async (err, results) => {
        if (err) {
            console.log(err.message);
            return;
        }
        if (results.length > 0) {
            const hashpass = results[0].password;

            if (await argon2.verify(hashpass, password)) {
                // password match
                // res.send("create session then redirect");

                if (results[0].type == 0) {
                    req.session.user = results[0];
                    //console.log(req.session.user);
                    res.redirect("/userIndex");
                } else {
                    req.session.admin = results[0];
                    res.redirect("/adminViewBlogs");
                }

            } else {
                // password did not match
                alert = "Invalid password";
                res.render("login", { title: "login page", alert });
            }
        } else {
            alert = "Invalid username";
            res.render("login", { title: "login page", alert });
        }
    });
};



//user
exports.getUserIndex = (req, res) => {

    const sql = "SELECT p.*, c.name AS `category`, COALESCE(SUM(v.plusone), 0) AS totalView FROM post_tbl p INNER JOIN category_tbl c ON p.category_id = c.id LEFT JOIN views v ON p.id = v.postid WHERE p.status = 1 AND p.`delete_flag` = 0 GROUP BY p.id ORDER BY totalView desc LIMIT 3 ";
    con.query(sql, (err, blogs) => {
        if (err) {
            res.send(err.message);
            return;
        }
        res.render("user/index", { title: "User Home", blogs, stripTags: striptags });
    });
};


exports.createBlog = (req, res) => {

    const sql = "SELECT * FROM category_tbl";
    con.query(sql, (err, category) => {
        if (err) {
            res.send(err.message);
            return;
        }
        let posted = req.flash("success");
        let drafted = req.flash("warning");
        res.render("user/createBlog", { category, posted, drafted });
    });
};


exports.userPostBlog = (req, res) => {
    const isSaveDraftClicked = req.body.saveDraft !== undefined;
    const isUploadClicked = req.body.upload !== undefined;
    const userid = req.body.userid;
    const title = req.body.title;
    const content = req.body.content;
    const category = req.body.category;
    let sql = "";
    let values = [];



    if (isUploadClicked) {

        if (req.file) {
            console.log(req.file);

            sql = "INSERT INTO post_tbl (user_id, category_id, title, content, status, images) VALUES (?, ?, ?, ?, ?, ?)";
            values = [userid, category, title, content, 1, req.file.filename];
        } else {

            sql = "INSERT INTO post_tbl (user_id, category_id, title, content, status) VALUES (?, ?, ?, ?, ?)";
            values = [userid, category, title, content, 1];

        }


        con.query(sql, values, (err, results) => {
            if (err) {
                console.log(err.message);

            }
            req.flash("success", "Blog Posted");
            res.redirect("/createBlog");
        });


    } else {

        if (req.file) {
            sql = "INSERT INTO post_tbl (user_id, category_id, title, content, status, images) VALUES (?, ?, ?, ?, ?, ?)";
            values = [userid, category, title, content, 0, req.file.filename];
        } else {

            sql = "INSERT INTO post_tbl (user_id, category_id, title, content, status) VALUES (?, ?, ?, ?, ?)";
            values = [userid, category, title, content, 0];

        }

        con.query(sql, values, (err, results) => {
            if (err) {
                console.log(err.message);

            }
            req.flash("warning", "Blog Saved as draft");
            res.redirect("/createBlog");
        });

    }


};