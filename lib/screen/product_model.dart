class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.numericPrice,
    required this.image,
    required this.shortInfo,
    required this.description,
    required this.specifications,
    required this.category,
    required this.stock,
    this.material = 'High Grade Steel',
    this.size = 'Standard',
    this.threadType = 'Standard Metric',
    this.headType = 'Standard',
    this.finish = 'Zinc Plated',
    this.grade = '8.8 Industrial',
    this.application = 'Structural & Manufacturing Engineering',
  });

  final String id;
  final String name;
  final String price;
  final double numericPrice;
  final String image;
  final String shortInfo;
  final String description;
  final String specifications;
  final String category;
  final String stock;
  final String material;
  final String size;
  final String threadType;
  final String headType;
  final String finish;
  final String grade;
  final String application;
}

/// Shared catalog. Image paths match the actual files in assets/images.
/// Order matches the reference product list: nut, screw, bolt, drill bit, anchor.
final List<Product> kSampleProducts = [
  const Product(
    id: 'hex-nut',
    name: 'Hex Nut',
    price: 'Rs. 15.50/pcs',
    numericPrice: 15.50,
    image: 'assets/images/HEX_NUT.PNG',
    category: 'Fasteners',
    stock: 'In Stock (500+ pcs)',
    shortInfo: 'High-strength hex nut for heavy-duty joins.',
    description:
        'Precision-machined steel hex nut for secure fastening in industrial, structural, and construction applications.',
    specifications:
        'Material: Stainless Steel (304)\nSize: M12\nFinish: Zinc Plated\nGrade: 8.8\nThread Type: Standard Metric\nApplication: Industrial Machinery & Structural Engineering',
    material: 'Stainless Steel (304)',
    size: 'M12 Standard',
    threadType: 'Standard Metric Full Thread',
    headType: 'Hexagonal',
    finish: 'Zinc Plated Anti-Corrosive',
    grade: '8.8 High Tensile',
    application: 'Industrial Machinery & Structural Engineering',
  ),
  const Product(
    id: 'phillips-screw',
    name: 'Phillips Screw',
    price: 'Rs. 8.00/pcs',
    numericPrice: 8.00,
    image: 'assets/images/3.PNG',
    category: 'Fasteners',
    stock: 'In Stock (800+ pcs)',
    shortInfo: 'Countersunk Phillips head screw for timber and fittings.',
    description:
        'Corrosion-resistant Phillips drive screw with a sharp point for clean driving into wood and light metal.',
    specifications:
        'Material: Stainless Steel\nDrive: Phillips\nHead: Countersunk\nFinish: Bright Zinc\nApplication: Joinery, fittings, general assembly',
    material: 'Stainless Steel',
    size: 'M4 x 25mm',
    threadType: 'Coarse wood thread',
    headType: 'Phillips Countersunk',
    finish: 'Bright Zinc',
    grade: 'A2',
    application: 'Joinery, fittings, general assembly',
  ),
  const Product(
    id: 'hex-bolt',
    name: 'Hex Bolt',
    price: 'Rs. 45.00/pcs',
    numericPrice: 45.00,
    image: 'assets/images/Capture.PNG',
    category: 'Fasteners',
    stock: 'In Stock (350+ pcs)',
    shortInfo: 'Heavy-duty hexagonal head bolt for structural frames.',
    description:
        'High tensile fully-threaded hexagonal head bolt designed for heavy load-bearing frames and machine assembly.',
    specifications:
        'Material: High Tensile Steel\nSize: M10 x 50mm\nFinish: Hot-Dip Galvanized\nGrade: 8.8\nThread Type: Full Thread\nApplication: Structural Framing & Heavy Machinery',
    material: 'High Tensile Steel',
    size: 'M10 x 50mm',
    threadType: 'Full Thread',
    headType: 'Hexagonal',
    finish: 'Hot-Dip Galvanized',
    grade: '8.8',
    application: 'Structural Framing & Heavy Machinery',
  ),
  const Product(
    id: 'drill-bit',
    name: 'HSS Drill Bit',
    price: 'Rs. 25.00/pcs',
    numericPrice: 25.00,
    image: 'assets/images/6.PNG',
    category: 'Power Tools',
    stock: 'In Stock (200+ pcs)',
    shortInfo: 'High-speed steel twist drill bit for metal and timber.',
    description:
        'Precision ground HSS twist drill bit offering wear resistance and heat dissipation when drilling alloy steels and hardwoods.',
    specifications:
        'Material: M2 High Speed Steel\nSize: 6.0 mm x 93 mm\nFlute Type: Spiral Flute\nFinish: Amber Titanium Coated\nPoint Angle: 135 Degree Split Point',
    material: 'HSS M2 Grade',
    size: '6.0 mm Diameter',
    threadType: 'Twin Spiral Flute',
    headType: '135° Split Point',
    finish: 'Titanium Nitride Coated',
    grade: 'Industrial Pro',
    application: 'Metal, Stainless Steel & Hardwood Drilling',
  ),
  const Product(
    id: 'anchor-bolt',
    name: 'Anchor Bolt',
    price: 'Rs. 65.00/pcs',
    numericPrice: 65.00,
    image: 'assets/images/5.PNG',
    category: 'Fasteners',
    stock: 'In Stock (180+ pcs)',
    shortInfo: 'High-load wedge anchor for heavy concrete mounting.',
    description:
        'Heavy duty through-bolt wedge expansion anchor engineered for machinery and structural columns in concrete.',
    specifications:
        'Material: Zinc Plated Carbon Steel\nSize: M12 x 100mm\nMin. Embedment: 65mm\nFinish: Zinc Clear\nApproval: ETA Option 1',
    material: 'Carbon Steel Heavy Grade',
    size: 'M12 x 100mm',
    threadType: 'Partial Metric Thread',
    headType: 'Hex Nut with Expansion Clip',
    finish: 'Zinc Plated',
    grade: 'Grade 5.8',
    application: 'Concrete Foundations & Heavy Equipment',
  ),
  const Product(
    id: 'flat-washer',
    name: 'Flat Washer',
    price: 'Rs. 5.00/pcs',
    numericPrice: 5.00,
    image: 'assets/images/4.PNG',
    category: 'Fasteners',
    stock: 'In Stock (1000+ pcs)',
    shortInfo: 'Even load distribution washer for bolt and nut assemblies.',
    description:
        'Engineered zinc-plated flat steel washer designed to distribute clamping load evenly and prevent surface damage.',
    specifications:
        'Material: Mild Steel\nInner Diameter: 13mm\nOuter Diameter: 24mm\nThickness: 2.5mm\nFinish: Yellow Zinc Plated',
    material: 'Carbon Steel / Zinc Plated',
    size: 'M12 (24mm OD)',
    threadType: 'Clearance Hole',
    headType: 'Flat Circular',
    finish: 'Yellow Zinc Plated',
    grade: 'DIN 125A',
    application: 'General Fastening & Vibration Dampening',
  ),
  const Product(
    id: 'tool-kit',
    name: 'Professional Tool Kit',
    price: 'Rs. 1,450.00',
    numericPrice: 1450.00,
    image: 'assets/images/toolkit.png',
    category: 'Tool Kits',
    stock: 'In Stock (45 kits)',
    shortInfo: 'Comprehensive industrial technician toolkit.',
    description:
        'Complete multi-purpose workshop tool kit with wrenches, pliers, and drivers for plant and site work.',
    specifications:
        'Includes: Wrenches, pliers, hex keys\nCase: Workshop set\nWarranty: 2 Years',
    material: 'Chrome Vanadium (Cr-V)',
    size: 'Workshop set',
    threadType: 'Standard',
    headType: 'Ergonomic Grips',
    finish: 'Matte Chrome Plated',
    grade: 'Workshop Professional',
    application: 'Plant Maintenance & Site Installations',
  ),
  const Product(
    id: 'claw-hammer',
    name: 'Claw Hammer',
    price: 'Rs. 320.00',
    numericPrice: 320.00,
    image: 'assets/images/Hathodi.PNG',
    category: 'Hand Tools',
    stock: 'In Stock (85 pcs)',
    shortInfo: 'Drop-forged carbon steel head with anti-shock grip.',
    description:
        'Heavy-duty steel claw hammer with balanced head weight and shock-absorbing handle for daily usage.',
    specifications:
        'Head Weight: 16 oz (450g)\nMaterial: Drop Forged High Carbon Steel\nHandle: Anti-Shock Grip\nClaw: Curved Nail Puller',
    material: 'Drop Forged Carbon Steel',
    size: '16 oz (450g)',
    threadType: 'N/A',
    headType: 'Smooth Face & Curved Claw',
    finish: 'Polished Steel & Powder Coat',
    grade: 'Contractor Grade',
    application: 'Carpentry, Construction & Fabrication',
  ),
  const Product(
    id: 'pliers',
    name: 'Combination Pliers',
    price: 'Rs. 210.00',
    numericPrice: 210.00,
    image: 'assets/images/pakkad.png',
    category: 'Hand Tools',
    stock: 'In Stock (120 pcs)',
    shortInfo: 'High-leverage gripping and wire cutting pliers.',
    description:
        'Induction-hardened cutting edges suitable for hard wire and copper. Two-component handle for leverage.',
    specifications:
        'Length: 8 Inch (200 mm)\nCutting Capacity: 2.5 mm Wire\nMaterial: Forged Alloy Steel\nHandle: Insulated Non-Slip Grip',
    material: 'Forged Alloy Steel',
    size: '8 Inch (200mm)',
    threadType: 'N/A',
    headType: 'Toothed Jaw & Wire Cutter',
    finish: 'Black Phosphate & Polished',
    grade: 'Industrial Standard',
    application: 'Electrical, Maintenance & Assembly',
  ),
  const Product(
    id: 'step-ladder',
    name: 'Step Ladder',
    price: 'Rs. 2,850.00',
    numericPrice: 2850.00,
    image: 'assets/images/lader.png',
    category: 'Equipment',
    stock: 'In Stock (25 units)',
    shortInfo: 'Heavy-duty anti-slip folding access ladder.',
    description:
        'Sturdy, corrosion-resistant aluminum step ladder with ribbed non-slip treads and stabilizing feet.',
    specifications:
        'Load Capacity: 150 kg\nMaterial: Aluminum Alloy\nSafety: Ribbed non-slip treads',
    material: 'High-Strength Aluminum Alloy',
    size: 'Workshop access ladder',
    threadType: 'N/A',
    headType: 'Top Guardrail',
    finish: 'Anodized Silver',
    grade: 'EN131 Certified',
    application: 'Warehouse, Workshop & Domestic Access',
  ),
];

Product? productById(String id) {
  for (final product in kSampleProducts) {
    if (product.id == id) return product;
  }
  return null;
}
