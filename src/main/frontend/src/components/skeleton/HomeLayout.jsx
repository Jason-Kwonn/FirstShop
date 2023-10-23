import NavBar from "./NavBar.jsx";
import Footer from "./Footer.jsx";
import Cards from "./Cards.jsx";

function HomeLayout() {
    return (
        <>
            <NavBar/>
            <div className="container">
                {Array.from({ length: 25 }).map((_, i) => (
                    // 3개의 카드마다 새로운 행 시작
                    i % 3 === 0 ? (
                        <div className="row" key={i/3}>
                            {[0, 1, 2].map(j => (
                                <div className="col-md-4" key={i+j}>
                                    <Cards />
                                </div>
                            ))}
                        </div>
                    ) : null
                ))}
            </div>
            <Footer/>
        </>
    );
}

export default HomeLayout;
