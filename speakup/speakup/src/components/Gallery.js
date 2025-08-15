import React, { useState } from "react";
import "react-image-lightbox/style.css";
import Lightbox from "react-image-lightbox";

export default function Gallery() {
  const images = [
    "/images/protest1.jpg",
    "/images/protest2.jpg",
    "/images/protest3.jpg",
    "/images/community1.jpg",
    "/images/community2.jpg",
    "/images/community3.jpg"
  ];

  const [photoIndex, setPhotoIndex] = useState(0);
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <h1>Gallery</h1>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "10px" }}>
        {images.map((img, index) => (
          <img
            key={index}
            src={img}
            alt={`Gallery ${index}`}
            style={{ width: "100%", cursor: "pointer", borderRadius: "5px" }}
            onClick={() => { setPhotoIndex(index); setIsOpen(true); }}
          />
        ))}
      </div>
      {isOpen && (
        <Lightbox
          mainSrc={images[photoIndex]}
          nextSrc={images[(photoIndex + 1) % images.length]}
          prevSrc={images[(photoIndex + images.length - 1) % images.length]}
          onCloseRequest={() => setIsOpen(false)}
          onMovePrevRequest={() => setPhotoIndex((photoIndex + images.length - 1) % images.length)}
          onMoveNextRequest={() => setPhotoIndex((photoIndex + 1) % images.length)}
        />
      )}
    </div>
  );
}
