class FakeData {
  static const CONSUMBALE_TYPE_EPI = "EPI";
  static const CONSUMBALE_TYPE_EQUIPMENT = "Equipement";

  static final equipments = [
    {
      "id": 0,
      "name": "Compteurs de particules portatifs",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 1,
      "name": "Enregistreur thermohygromètre",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 2,
      "name": "Thermomètre infrarouge",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 3,
      "name": "Luxmètre",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 4,
      "name": "Vibromètre",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 5,
      "name": "Les sonomètres",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 6,
      "name": "Calibreurs acoustiques",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 7,
      "name": "Analyseur de ventilation portable",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 8,
      "name": "Appareil de mesure des expositions chimiques portable",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 9,
      "name": "Cardiofréquencemètre",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 10,
      "name": "Dosimètre portable (électromagnétiques)",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
    {
      "id": 11,
      "name": "Dosimètre de vibration portable",
      "quantity": 3,
      "available": 3,
      "in_use": 0,
    },
  ];

  static final consumables = [
    {
      "id": 0,
      "name": "Cartouche",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 1,
      "name": "Demi masque à filtre ",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 2,
      "name": "Gants nitrile",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 3,
      "name": "Gants en cuir",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 4,
      "name": "Lunettes de protection",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 5,
      "name": "Masque anti poussière",
      "type": CONSUMBALE_TYPE_EPI,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
    {
      "id": 6,
      "name": "Filtres",
      "type": CONSUMBALE_TYPE_EQUIPMENT,
      "quantity": 20,
      "available": 20,
      "in_use": 0,
    },
  ];

  static final people = [
    {
      "name": "John Doe",
      "picture": "https://avatar.iran.liara.run/public/boy",
      "role": "Technician",
      "available": true,
    },
    {
      "name": "Maria Domingez",
      "picture": "https://avatar.iran.liara.run/public/girl",
      "role": "Technician",
      "available": false,
    },
    {
      "name": "Alfred Juan",
      "picture": "https://avatar.iran.liara.run/public",
      "role": "Technician",
      "available": true,
    },
  ];
}
