import { Form, Button } from 'react-bootstrap';
import { Typeahead } from 'react-bootstrap-typeahead';
import 'react-bootstrap-typeahead/css/Typeahead.css';
import { useState, useRef } from "react";
import {useNavigate} from "react-router-dom";

function SearchBar() {
    const [query, setQuery] = useState('');
    const [results, setResults] = useState([]);
    const typeaheadRef = useRef(null);
    const navigate = useNavigate();

    const handleInputChange = async (input) => {


        if (input.length >= 1) {
            const response = await fetch(`/product/searchProduct/${input}`);
            const data = await response.json();
            setResults(data);  // List<String>
            setQuery(input);
        } else {
            setResults([]);
        }

    };

    const handleSubmit = (event) => {
        event.preventDefault();
        console.log("보낸 query 값 : "+query);
        navigate(`/product/getProduct/${query}`);
    };

    return (
        <Form className="d-flex" onSubmit={handleSubmit}>
            <Typeahead style={{marginLeft: '10px', marginRight: '10px' }}
                id="search-typeahead"
                // labelKey="item"  // map 필요 시 labelKey 사용 예정
                onInputChange={handleInputChange}
                onChange={selected => setQuery(selected[0])}
                options={results}
                placeholder="상품 or 래플 검색"
                ref={typeaheadRef}
                selected={query ? [query] : []}
            />
            <Button variant="outline-success" type="submit">Search</Button>
        </Form>
    );
}

export default SearchBar;
