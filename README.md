# Locations Code: A Universal GPS Address System

**Locations Code** is a mathematical geocoding algorithm that converts geographic coordinates into a stable, 8-character alphanumeric string. Designed specifically for **logistics, sorting, and last-mile delivery**, it provides a unique and universal alternative to traditional postal addresses.

---

## 🚀 Key Advantages
- **Universal Format:** Always 8 characters, regardless of the location.
- **Language Independent:** No translations or localized words (unlike what3words).
- **Global Uniqueness:** One code identifies one specific location worldwide without administrative descriptions (unlike Google Plus Codes).
- **Logistics Optimized:** Hierarchical structure allows sorting systems to recognize nearby locations easily.
- **Barcode Ready:** Uses standard alphanumeric characters, making it 100% compatible with linear barcodes.

---

## 📊 Comparison with what3words
While what3words uses three dictionary words, Locations Code focuses on technical efficiency and universal standardization.

| Characteristic | what3words | Locations Code |
| :--- | :--- | :--- |
| **Format** | Variable (3 words) | **Fixed (8 characters)** |
| **Language** | Localized (Changes by country) | **Universal (Standard)** |
| **Infrastructure** | Proprietary Database | **Mathematical Conversion** |
| **Spatial Relationship**| Randomized (Causal) | **Hierarchical (Similar codes nearby)** |
| **Barcode Compatibility**| Limited (Accents/Spaces) | **High (Standard Alphanumeric)** |

---

## 📊 Comparison with Google Plus Code
Locations Code solves the "Administrative Dependence" issue found in Google's Compound Plus Codes.

| Characteristic | Google Plus Code (Compound) | Locations Code |
| :--- | :--- | :--- |
| **Global Uniqueness** | NO (Requires City/State) | **YES (Global Identifier)** |
| **Admin. Dependence** | High (Linked to city names) | **None (Pure Coordinate Conversion)** |
| **Precision** | High (~3 meters) | **Medium (~30 meters / 102 feet)** |
| **Independence** | Controlled by Google | **Algorithm-based / Independent** |
| **Primary Use Case** | Consumer Navigation | **Sorting and Logistics** |

---

## 🛠 How it Works
The algorithm ensures an accuracy of approximately **102 feet (30 meters)**. This precision is intentionally calibrated to ensure that every building or home has its own unique and stable code, reducing failed deliveries caused by changing administrative boundaries or ambiguous street addresses.

---

## ⚙️ Technical Implementation & Portability
The algorithm is designed for maximum interoperability and low-resource environments. Unlike other geocoding systems, it does not require complex libraries or heavy dependencies.

- **Pure Mathematical Core:** The conversion relies on bit-interleaving and a shifted Base-34 encoding. This ensures a 1:1 relationship between GPS coordinates and the 8-character string, with no "black-box" processing.
- **High-Efficiency Sorting:** Thanks to the interleaving logic, nearby locations share similar prefixes. This allows logistics software to perform spatial sorting and route optimization using simple string comparison, significantly reducing computational overhead.
- **Zero-Code Integration (Excel/VBA):** To facilitate immediate adoption in corporate environments, a **universal Excel formula** is available. This allows non-developers to process thousands of coordinates directly within spreadsheets, making the system "Plug & Play" for existing logistics databases.
- **Offline & Stateless:** No internet connection or API calls are needed. The transformation is entirely local, ensuring data privacy and 100% uptime.

---


---

## 👨‍💻 Project Info
- **Author:** Aldo Buondonno
- **Official Website:** [locationscode.com](https://www.locationscode.com)
- **Status:** Open for integration in logistics and sorting software.

---
© **Locations Code** - A new way of thinking about addresses.
